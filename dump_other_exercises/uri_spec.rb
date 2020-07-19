#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'uri'

RSpec.describe URI do
  include_examples 'URI parser', URI

  it 'defaults the port for an http URI to 80' do |example|
    p example.metadata
    expect(URI.parse('http://example.com/').port).to eq 80
  end

  it 'defaults the port for an https URI to 443' do
    expect(URI.parse('https://example.com/').port).to eq 443
  end
end
