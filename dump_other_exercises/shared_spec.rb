RSpec.shared_examples 'URI parser' do |parser_class|
    it 'parses the scheme' do
        expect(parser_class.parse('https://a.com/').scheme).to eq 'https'
    end

    it 'parses the host' do
        expect(parser_class.parse('http://foo.com/').host).to eq 'foo.com'
    end

    context 'when the port is present in the URI' do
        it 'parses the port' do
            expect(parser_class.parse('http://example.com:9876').port).to eq 9876
        end    
    end

    it 'parses the default_port for an http URI to 80' do
        expect(parser_class.parse('http://example.com/').default_port).to eq 80
    end

    it 'parses the default_port for an https URI to 80' do
        expect(parser_class.parse('https://example.com/').default_port).to eq 443
    end

    it 'parses the path' do
        expect(parser_class.parse('http://a.com/foo').path).to eq '/foo'
    end
end