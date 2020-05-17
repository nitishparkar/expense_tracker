require_relative '../../../app/api'
require 'rack/test'


module ExpenseTracker 
  RSpec.describe API do
    include Rack::Test::Methods

    def app
      API.new(ledger: ledger)
    end

    let(:ledger) { instance_double('ExpenseTracker::Ledger') }

    describe 'POST /expenses' do
      context 'when the expense is successfully recorded' do
        let(:expense) { { 'some' => 'data' } }

        before do
          allow(ledger).to receive(:record) .with(expense) .and_return(RecordResult.new(true, 417, nil))
        end
        
        it 'returns the expense id' do
          post '/expenses', JSON.generate(expense)
            
          expect(parsed_response).to include('expense_id' => 417)
        end

        it 'responds with a 200 (OK)' do
          post '/expenses', JSON.generate(expense)
          
          expect(last_response.status).to eq(200)
        end 
      end
    
      context 'when the expense fails validation' do
        let(:expense) { { 'some' => 'data' } }

        before do
          allow(ledger).to receive(:record) .with(expense) .and_return(RecordResult.new(false, -1, 'Expense incomplete'))
        end
        
        it 'returns an error message' do
          post '/expenses', JSON.generate(expense)
            
          expect(parsed_response['error']).to eq('Expense incomplete')  
        end

        it 'responds with a 422 (Unprocessable entity)' do
          post '/expenses', JSON.generate(expense)
          
          expect(last_response.status).to eq(422)
        end
      end
    end

    describe 'GET /expenses/:date' do
      let(:date) { '2017-06-12' }

      context 'when expenses exist on the given date' do
        before do
          allow(ledger).to receive(:expenses_on).with(date)
            .and_return([
                Record.new(417, 'Starbucks', '300'), 
                Record.new(317, 'CCD', '200')
            ])
        end

        it 'returns the expense records as JSON' do
          get 'expenses/' + date

          expect(parsed_response).to match([
                a_hash_including('expense_id' => 417), 
                a_hash_including('expense_id' => 317)
            ])
        end

        it 'responds with a 200 (OK)' do
          get 'expenses/' + date

          expect(last_response.status).to eq(200)
        end
      end

      context 'when there are no expenses on the given date' do
        before do
          allow(ledger).to receive(:expenses_on).with(date).and_return([])
        end

        it 'returns an empty array as JSON' do
          get 'expenses/' + date

          expect(parsed_response).to eq([])
        end

        it 'responds with a 200 (OK)' do
          get 'expenses/' + date

          expect(last_response.status).to eq(200)
        end
      end 
    end
  end
end