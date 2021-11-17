# Wrapper class for simplifying using %{calling_module} with Hiera
class accounts::instances(
  $groups                   = {},
  $ssh_keys                 = {},
  $users                    = {},
  $usergroups               = {},
  $accounts                 = {},
  $merge_strategy           = 'deep',
  $start_uid                = undef,
  $start_gid                = undef,
  $purge_ssh_keys           = false,
  $ssh_authorized_key_title = '%{ssh_key}-on-%{account}',
) {

  if empty($groups) {
    $groups_data = lookup('accounts::groups', Hash, $merge_strategy, {})
  }
  if empty($ssh_keys) {
    $ssh_keys_data = lookup('accounts::ssh_keys', Hash, $merge_strategy, {})
  }
  if empty($users) {
    $users_data = lookup('accounts::users', Hash, $merge_strategy, {})
  }
  if empty($usergroups) {
    $usergroups_data = lookup('accounts::usergroups', Hash, $merge_strategy, {})
  }
  if empty($accounts) {
    $accounts_data =  lookup('accounts::accounts', Hash, $merge_strategy, {})
  }
  class { 'accounts':
    groups                   => $groups_data,
    ssh_keys                 => $ssh_keys_data,
    users                    => $users_data,
    usergroups               => $usergroups_data,
    accounts                 => $accounts_data,
    start_uid                => $start_uid,
    start_gid                => $start_gid,
    purge_ssh_keys           => $purge_ssh_keys,
    ssh_authorized_key_title => $ssh_authorized_key_title,
  }
}
