package delegation_policy

default allow = false

allow {
    is_manager_of_team(input.requesting_customer, input.target_customer)
}

allow {
    is_same_team(input.requesting_customer, input.target_customer)
}

is_manager_of_team(requesting_customer, target_customer) {
    team := get_team_for_member(target_customer)
    team.manager == requesting_customer
}

is_same_team(requesting_customer, target_customer) {
    team := get_team_for_member(requesting_customer)
    target_team := get_team_for_member(target_customer)
    team.id == target_team.id
}

get_team_for_member(member) = team {
    some team_id
    data.teams[team_id] = team
    member == team.members[_]
}
