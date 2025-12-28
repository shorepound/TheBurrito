module ApplicationHelper
	def card_taqueria(extra_classes = "", &block)
		classes = ["card-taqueria", extra_classes].join(" ").strip
		content_tag(:div, class: classes) do
			capture(&block)
		end
	end
end
