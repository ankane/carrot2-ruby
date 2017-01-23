require_relative "test_helper"

class Carrot2Test < Minitest::Test
  def test_cluster
    documents = [
      "Sign up for an exclusive coupon.",
      "Exclusive members get a free coupon.",
      "Coupons are going fast.",
      "This is completely unrelated to the other documents."
    ]

    assert_equal ["Coupon", "Exclusive", "Other Topics"], carrot2.cluster(documents)["clusters"].map { |c| c["phrases"].first }
  end

  def test_bad_request
    error = assert_raises(Carrot2::Error) { carrot2.request({}) }
    assert_includes error.message, "Error 400"
  end

  def carrot2
    @carrot2 ||= Carrot2.new
  end
end
