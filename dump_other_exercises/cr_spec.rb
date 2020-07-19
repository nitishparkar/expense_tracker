require_relative 'cr'

RSpec.describe CookieRecipe, '#ingredients' do 
	it do
		expect(CookieRecipe.new.ingredients).to include(:butter, :milk, :eggs) 
	end

	it do
		expect(CookieRecipe.new.ingredients).not_to include(:fish_oil)
	end 
end

