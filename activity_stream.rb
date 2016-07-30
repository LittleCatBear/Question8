class ActivityStream
  DATA_OBJECT = [
    {
      actor: "Bob",
      item: "Quote",
      action: "Create",
      key: "quote.created",
      created_at: "Tue, 12 Nov 2013 00:31:14 UTC +00:00",
      updated_at: "Tue, 14 Nov 2013 00:31:14 UTC +00:00"
    },
    {
      actor: "Bob",
      item: "Quote",
      action: "Update",
      key: "quote.updated",
      created_at: "Tue, 13 Nov 2013 00:31:14 UTC +00:00",
      updated_at: "Tue, 13 Nov 2013 00:31:14 UTC +00:00"
    },
    {
      actor: "Jean",
      item: "Article",
      action: "Comment",
      key: "article.commented_on",
      created_at: "Tue, 12 Nov 2013 00:31:14 UTC +00:00",
      updated_at: "Tue, 12 Nov 2013 00:31:14 UTC +00:00"
    }
  ]

  VOWELS = %w(a e i o u y)

  def order_activity
    DATA_OBJECT.sort_by do |data|
      data[:updated_at]
    end
  end

  def build_activity_string_with(item)
    parsing = item[:key].split('.')

    subject = item[:actor]
    object = parsing[0]
    verb = parsing[1].split('_')
    article = get_article_for object

    "#{subject} #{verb.join(' ')} #{article} #{object}"
  end

  def get_article_for(object)
    initial = object[0,1]
    VOWELS.include?(initial) ? "an" : "a"
  end

  def render_activity
    data = order_activity
    data.each do |item|
      puts build_activity_string_with(item)
    end
  end
end