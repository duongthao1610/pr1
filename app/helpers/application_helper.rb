module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title = " "
    base_title = "Cosmetic store"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def index_for object, index, per_page
    object ||= 1
    (object.to_i - 1)*per_page + index + 1
  end
end
