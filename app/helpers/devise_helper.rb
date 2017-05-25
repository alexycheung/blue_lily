module DeviseHelper
	# Return flash notification when signup fails
	def devise_error_messages!
		if resource.errors.any?
    	"<div class='flash alert'>#{resource.errors.full_messages.first.humanize}</div>".html_safe
    end
  end
end