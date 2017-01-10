# Install and configure php apache
#
# === Parameters
#
# [*inifile*]
#   The path to the ini file
#
# [*settings*]
#   Hash with nested hash of key => value to set in inifile
#
class php::apache(
  $inifile  = $::php::params::apache_inifile,
  $settings = {}
) inherits ::php::params {

  if $caller_module_name != $module_name {
    warning('php::apache is private')
  }

  validate_absolute_path($inifile)
  validate_hash($settings)

  $real_settings = deep_merge($settings, hiera_hash('php::apache::settings', {}))
  $settingsdir = dirname($inifile)

  file { $settingsdir:
    ensure => directory
  }

  ::php::config { 'apache':
    file   => $inifile,
    config => $real_settings,
  }
}
