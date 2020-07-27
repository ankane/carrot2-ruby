require_relative "test_helper"

class Carrot2Test < Minitest::Test
  def test_list
    list = carrot2.list
    assert_equal ["Bisecting K-Means", "Lingo", "STC"], list["algorithms"].keys.sort
  end

  def test_cluster
    assert_phrases ["Coupon", "Exclusive"], documents
  end

  def test_language
    documents = [
      "Inscrivez-vous pour un coupon exclusif",
      "Les membres exclusifs reçoivent un coupon gratuit.",
      "Les coupons vont vite.",
      "Ceci n'a rien à voir avec les autres documents."
    ]

    assert_phrases ["Coupon", "Exclusif"], documents, language: "French"
  end

  def test_hash_documents
    assert_phrases ["Coupon", "Exclusive"], documents
  end

  def test_template
    assert_phrases ["Coupon", "Exclusive"], documents, template: "lingo"
  end

  def test_bad_template
    error = assert_raises(Carrot2::Error) do
      carrot2.cluster(documents, template: "lingo?&other")
    end
    assert_equal "Template not available: lingo?&other", error.message
  end

  private

  def carrot2
    @carrot2 ||= Carrot2.new
  end

  def documents
    [
      "Sign up for an exclusive coupon.",
      "Exclusive members get a free coupon.",
      "Coupons are going fast.",
      "This is completely unrelated to the other documents."
    ]
  end

  def assert_phrases(expected, documents, **options)
    assert_equal expected, carrot2.cluster(documents, **options)["clusters"].map { |c| c["labels"].first }
  end
end
