#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'addressable'
require 'shared_spec'

RSpec.describe Addressable do
  it_behaves_like 'URI parser', Addressable::URI

  it 'defaults the port to nil if not specified' do
    expect(Addressable::URI.parse('http://example.com/').port).to eq nil
  end
end
