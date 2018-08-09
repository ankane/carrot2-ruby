require_relative "test_helper"

class Carrot2Test < Minitest::Test
  def test_cluster
    documents = [
      "Sign up for an exclusive coupon.",
      "Exclusive members get a free coupon.",
      "Coupons are going fast.",
      "This is completely unrelated to the other documents."
    ]

    assert_cluster documents, ["Coupon", "Exclusive"]
  end

  def test_language
    documents = [
      "Inscrivez-vous pour un coupon exclusif",
      "Les membres exclusifs reçoivent un coupon gratuit.",
      "Les coupons vont vite.",
      "Ceci n'a rien à voir avec les autres documents."
    ]

    assert_cluster documents, ["Coupon", "Exclusif"], language: "French"
  end

  def test_bad_request
    error = assert_raises(Carrot2::Error) { carrot2.request({}) }
    assert_includes error.message, "Error"
  end

  private

  def carrot2
    @carrot2 ||= Carrot2.new
  end

  def assert_cluster(documents, expected, **options)
    assert_equal expected + ["Other Topics"], carrot2.cluster(documents, **options)["clusters"].map { |c| c["phrases"].first }
  end
end
