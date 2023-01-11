set_1 = [
	{
		city_type: 'low_cost',
		start_date: '9/1/15',
		end_date: '9/3/15'
	}
]

set_2 = [
	{
		city_type: 'low_cost',
		start_date: '9/1/15',
		end_date: '9/1/15',
	},
	{
		city_type: 'high_cost',
		start_date: '9/2/15',
		end_date: '9/6/15',
	},
	{
		city_type: 'low_cost',
		start_date: '9/6/15',
		end_date: '9/8/15',
	}
]

set_3 = [
	{
		city_type: 'low_cost',
		start_date: '9/1/15',
		end_date: '9/3/15',
	},
	{
		city_type: 'high_cost',
		start_date: '9/5/15',
		end_date: '9/7/15',
	},
	{
		city_type: 'high_cost',
		start_date: '9/8/15',
		end_date: '9/8/15',
	}
]

set_4 = [
	{
		city_type: 'low_cost',
		start_date: '9/1/15',
		end_date: '9/1/15',
	},
	{
		city_type: 'low_cost',
		start_date: '9/1/15',
		end_date: '9/1/15',
	},
	{
		city_type: 'high_cost',
		start_date: '9/2/15',
		end_date: '9/2/15',
	},
	{
		city_type: 'high_cost',
		start_date: '9/2/15',
		end_date: '9/3/15',
	}
]

def calc_reimbursement(projects)

	travel_day_costs = {
		'low_cost'=>45,
		'high_cost'=>55
	}

	full_day_costs = {
		'low_cost'=>75,
		'high_cost'=>85
	}

	set_totals = []
	set_days = []
	doubled_set_dates = []
	
	projects.each do |project|

		start_day = project[:start_date].split('/')[1].to_i
		end_day = project[:end_date].split('/')[1].to_i

		project_full_cost = full_day_costs["#{project[:city_type]}"]
		project_travel_cost = travel_day_costs["#{project[:city_type]}"]

		project_days = (start_day..end_day).to_a
		
		doubled_project_dates = []
		project_days.each_with_index do |project_day, idx|

			is_travel_day = (idx == 0 || idx == project_days.length - 1)
			is_two_travel_days = doubled_set_dates.include?(project_day) && !doubled_project_dates.include?(project_day)

			if is_two_travel_days
				set_totals.delete_at set_days.find_index project_day

				set_totals.push(project_full_cost)
			else
				if is_travel_day
					set_totals.push(project_travel_cost)
					set_days.push(project_day)
				else
					set_totals.push(project_full_cost)
					set_days.push(project_day)
				end
			end

			doubled_project_dates.push(project_day)
			doubled_set_dates.push(project_day)
		end
	end

	puts "\n"
	puts "The total for this set of projects is $#{set_totals.sum}"

end

calc_reimbursement(set_1)
calc_reimbursement(set_2)
calc_reimbursement(set_3)
calc_reimbursement(set_4)