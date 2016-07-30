require 'rails_helper'
describe ActivityStream do
  let(:activity_stream) { ActivityStream.new }

  before(:each){
    DATA_OBJECT = [
    {
      actor: "Actor1",
      item: "Quote",
      action: "Create",
      key: "quote.created",
      created_at: "Tue, 13 Nov 2013 00:31:14 UTC +00:00",
      updated_at: "Tue, 13 Nov 2013 00:31:14 UTC +00:00"
    },
    {
      actor: "Actor1",
      item: "Quote",
      action: "Update",
      key: "quote.updated",
      created_at: "Tue, 13 Nov 2013 00:31:14 UTC +00:00",
      updated_at: "Tue, 14 Nov 2013 00:31:14 UTC +00:00"
    },
    {
      actor: "Actor2",
      item: "Article",
      action: "Comment",
      key: "article.commented_on",
      created_at: "Tue, 12 Nov 2013 00:31:14 UTC +00:00",
      updated_at: "Tue, 12 Nov 2013 00:31:14 UTC +00:00"
    }
  ]
  }

  context "#order_activity" do
    it "chronologically orders the activity stream" do
      data = activity_stream.order_activity
      expect(data[0][:item]).to eq("Article")
    end
  end

  context "#build_activity_string" do
    it "builds the activity string to display" do
      string = activity_stream.build_activity_string_with(DATA_OBJECT[0])
      expect(string).to eq("Actor1 created a quote")
    end
  end

  context "#get_article_for" do
    context "if an item starts with a vowel" do
      it "renders the article 'an'" do
        article = activity_stream.get_article_for("item")
        expect(article).to eq("an")
      end
    end

    context "if an item starts with a consonant" do
      it "renders the article 'a'" do
        article = activity_stream.get_article_for("consonant")
        expect(article).to eq("a")
      end
    end
  end

  context "#render_activity" do
    it "displays the activity stream" do
      expect{ activity_stream.render_activity }.to output("Actor2 commented on an article\nActor1 updated a quote\nActor1 created a quote\n").to_stdout
    end
  end

end