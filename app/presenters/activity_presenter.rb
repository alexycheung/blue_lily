class ActivityPresenter < SimpleDelegator
	attr_reader :activity

	def initialize(activity, view)
		super(view)
		@activity = activity
	end

	def render_activity
		"<tr>
			<td>
				<b>#{activity.user.name}</b> #{render_partial}
			</td>
			<td class='nowrap'>
				#{activity.created_at.strftime("%D")}
			</td>
		</tr>".html_safe
	end

	def render_partial
		locals = { activity: activity, presenter: self }
		locals[activity.trackable_type.underscore.to_sym] = activity.trackable
		render partial_path, locals
	end

	def partial_path
		partial_paths.detect do |path|
			lookup_context.template_exists? path, nil, true
		end || raise("No partial found for activity in #{partial_paths}")
	end

	def partial_paths
		[
			"activities/#{activity.trackable_type.underscore}/#{activity.action}",
			"activities/#{activity.trackable_type.underscore}",
			"activities/activity"	,
		]
	end
end