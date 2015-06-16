class gitolite (
  $package_ensure    = $gitolite::params::package_ensure,
  $package_name      = $gitolite::params::package_name,
  $home_dir          = $gitolite::params::home_dir,
  $admin_key_source  = undef,
  $admin_key_content = undef,
) inherits gitolite::params {
  validate_string($package_ensure)
  validate_string($package_name)
  validate_absolute_path($home_dir)

  if $admin_key_source and $admin_key_content {
    fail 'Parameters `admin_key_source` and `admin_key_content` are mutually exclusive'
  }
  if $admin_key_source {
    validate_string($admin_key_source)
  }
  if $admin_key_content {
    validate_string($admin_key_content)
  }

  anchor { "${module_name}::begin": } ->
  class { "${module_name}::install": } ->
  class { "${module_name}::config": } ->
  anchor { "${module_name}::end": }
}
