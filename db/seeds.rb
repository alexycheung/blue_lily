users = [
	{
		name: "Vencci Hung",
		phone: "415-555-5555",
		company: "Blue Lily Staging",
		email: "vencci@bluelilystaging.com",
		role: "admin",
		password: "password"
	},
	{
		name: "Alex Cheung",
		phone: "415-413-7210",
		company: "Blue Lily Staging",
		email: "cheung.ying.lon@gmail.com",
		role: "admin",
		password: "password"
	},
]

users.each do |user|
	unless User.where(email: user[:email]).any?
		User.create(
			name: user[:name],
			phone: user[:phone],
			company: user[:company],
			email: user[:email],
			role: user[:role],
			password: user[:password],
		)
	end
end