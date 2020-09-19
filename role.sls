
{% set definedRole = salt['grains.filter_by']({
    'timeserver': {'src': 'timeserver' },
    'empty': {'src': 'empty' },
    'missing': {'src': 'missing' }
	}, 
    default='empty',
    grain='role'
  ) 
%}


/dev/shm/salt.role:
  file.managed:
    - source: salt://managedFiles/role.{{definedRole.src}}
    - user: root
    - group: root
    - mode: 644

