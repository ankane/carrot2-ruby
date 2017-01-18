require_relative "test_helper"

class Carrot2Test < Minitest::Test
  def test_basic
    documents = [
      "Sign up for an exclusive coupon.",
      "Exclusive members get a free coupon.",
      "Coupons are going fast.",
      "This is completely unrelated to the other documents."
    ]

    carrot2 = Carrot2.new
    assert_equal ["Coupon", "Exclusive", "Other Topics"], carrot2.cluster(documents)["clusters"].map { |c| c["phrases"].first }
  end
end
