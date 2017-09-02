{
    "targets":
    [
        {
            "target_name": "csound",
            "sources":
            [
                "jscsound.cpp",
            ],
            'conditions':
            [
                 ['OS=="linux"',
                    {
                        'libraries':
                        [
                            '-L$(CSOUND_HOME)/../cs6make -lcsound64',
                        ],
                        'include_dirs':
                        [
                            '$(CSOUND_HOME)/include',
                        ],
 			'cflags_cc!':
			[
              		'-fno-exceptions',
			'-std=c++11',
            		],
		    }
               ],
               ['OS=="win"',
                    {
                        'defines':
                        [
                          'FOO',
                          'BAR=some_value',
                        ],
                       'libraries':
                        [
                            '-l$(CSOUND_HOME)/mingw64/csound64.lib',
                        ],
                        'include_dirs':
                        [
                            '$(CSOUND_HOME)/include',
                        ],
                    }
                ]
            ]
        }
    ]
}
