module LayoutsHelper
	def active_path(path)
		return "active" if current_page?(path)
	end
end