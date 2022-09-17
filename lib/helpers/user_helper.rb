class UserHelper
  
  def total_pages(total_followers, page_size)
    total_pages = total_followers / page_size
    total_pages = total_followers % page_size > 0 ? total_pages + 1 : total_pages
  end
end