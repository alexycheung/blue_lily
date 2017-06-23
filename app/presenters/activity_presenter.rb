class ActivityPresenter < SimpleDelegator
	attr_reader :activity

	def initialize(activity, view)
		super(view)
		@activity = activity
	end

	def render_activity
		"<tr id='activity_#{activity.id}'>
			<td class='nowrap'>
				#{activity.user.name}
			</td>
			<td class='activity-description'>
				#{render_partial}
			</td>
			<td class='nowrap'>
				#{activity.created_at.strftime("%D")}
			</td>
			<td class='nowrap'>
				#{activity.rollback_at.strftime('%D') if activity.is_rolled_back?}
			</td>
			<td class='nowrap'>
				#{link_to 'Rollback', rollback_activity_path(activity), method: :post, remote: true, class: 'pure-button pure-button-primary medium round' unless activity.is_rolled_back?}
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