#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
Event = Struct.new(:name, :capacity) do
  def purchase_ticket_for(guest)
    tickets_sold << guest
  end

  def tickets_sold
    @tickets_sold ||= []
  end

  def inspect
    "#<Event #{name.inspect} (capacity: #{capacity})>"
  end
end

RSpec.describe '`have_no_tickets_sold` matcher' do
  example 'passing expectation' do
    art_show = Event.new('Art Show', 100)

    expect(art_show).to have_no_tickets_sold
    expect(art_show).not_to have_any_tickets_sold
  end

  example 'failing expectation' do
    art_show = Event.new('Art Show', 100)
    # art_show.purchase_ticket_for(:a_friend)

    # expect(art_show).to have_no_tickets_sold
    expect(art_show).not_to have_any_tickets_sold
  end
end

RSpec.describe '`be_sold_out` matcher' do
  example 'passing expectation' do
    u2_concert = Event.new('U2 Concert', 10_000)
    10_000.times { u2_concert.purchase_ticket_for(:a_fan) }

    expect(u2_concert).to be_sold_out
  end

  example 'failing expectation' do
    u2_concert = Event.new('U2 Concert', 10_000)
    9_900.times { u2_concert.purchase_ticket_for(:a_fan) }

    expect(u2_concert).not_to be_sold_out
  end
end

RSpec::Matchers.define :have_no_tickets_sold do
  match { |art_show| art_show.tickets_sold.empty? }
  # failure_message { |art_show| failure_reason(art_show) + super()  }

private

  # def failure_reason(art_show)
  #   "has capacity of #{art_show.capacity}, "
  # end
end

RSpec::Matchers.define_negated_matcher :have_any_tickets_sold, :have_no_tickets_sold

# RSpec::Matchers.define :be_sold_out do
#   match { |art_show| art_show.tickets_sold.count == art_show.capacity }
# end

class BeSoldOut
  include RSpec::Matchers::Composable

  def matches?(art_show)
    values_match?(art_show.capacity, art_show.tickets_sold.count)
  end
end

module EventMatchers
  def be_sold_out
    BeSoldOut.new
  end
end

RSpec.configure do |config|
  config.include EventMatchers
end
