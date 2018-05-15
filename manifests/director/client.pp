# This define handles informing the director about a client.  This class should
# not be used directly, but only ever exported through the `bacula::client`
# define.  This is the director's configuration for a given client.
#
# @param port
# @param password
# @param file_retention
# @param job_retention
# @param autoprune
# @param conf_dir
#
# @example Taken from the `bacula::client` define:
#   @@bacula::director::client { $client:
#     port           => $port,
#     password       => $password,
#     autoprune      => $autoprune,
#     file_retention => $file_retention,
#     job_retention  => $job_retention,
#     tag            => "bacula-${director_name}",
#   }
#
define bacula::director::client (
  String       $address,
  Variant[String,Integer]      $port, # FIXME: Remove String
  String       $password,
  Bacula::Time $file_retention,
  Bacula::Time $job_retention,
  Variant[String,Boolean]      $autoprune, # FIXME: Remove String
  String       $conf_dir = $::bacula::conf_dir,
) {

  concat::fragment { "bacula-director-client-${name}":
    target  => "${conf_dir}/conf.d/client.conf",
    content => template('bacula/bacula-dir-client.erb'),
  }
}
