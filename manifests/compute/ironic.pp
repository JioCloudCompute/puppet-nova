class nova::compute::ironic (
  $keystone_user     = 'ironic',
  $keystone_tenant   = 'services',
  $keystone_password,
  $keystone_url      = 'http://localhost:35357/v2.0') {

  include nova::params

  package { 'python-ironicclient':
    ensure => 'present'
  }
  nova_config {
    'DEFAULT/compute_driver':         value => 'ironic.nova.virt.ironic.IronicDriver';
    'DEFAULT/scheduler_host_manager': value => 'ironic.nova.scheduler.ironic_host_manager.IronicHostManager';
    'DEFAULT/compute_manager':        value => 'ironic.nova.compute.manager.ClusteredComputeManager';
    'ironic/admin_username':          value => $keystone_user;
    'ironic/admin_password':          value => $keystone_password;
    'ironic/admin_url':               value => $keystone_url;
    'ironic/admin_tenant_name':       value => $keystone_tenant;
  }
}
