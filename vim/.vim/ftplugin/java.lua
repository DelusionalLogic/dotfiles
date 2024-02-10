local root_markers = {'gradlew', '.git', '.svn'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')

local home = os.getenv('HOME')
local workspace_dir = home .. '/.local/share/jdtls/workspace/' .. project_name

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Dosgi.checkConfiguration=true',
        '-Dosgi.sharedConfiguration.area=/usr/share/java/jdtls/config_linux',
        '-Dosgi.sharedConfiguration.area.readOnly=true',
        '-Dosgi.sharedConfiguration.cascaded=true',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', vim.fn.glob('/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),

        '-data', workspace_dir,
    },

    root_dir = root_dir,

    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },

            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
        },
    },

    init_options = {
        bundles = {},
    },

    configuration = {
        runtimes = {
            {
                name = "JavaSE-1.8",
                path = "/usr/lib/jvm/java-8-openjdk/",
            },
            {
                name = "JavaSE-11",
                path = "/usr/lib/jvm/java-11-openjdk/",
            },
            {
                name = "JavaSE-17",
                path = "/usr/lib/jvm/java-17-openjdk/",
            },
            {
                name = "JavaSE-20",
                path = "/usr/lib/jvm/java-20-openjdk/",
            },
        },
    },
}

config['on_attach'] = function(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    on_attach(client, bufnr)
end

local bundles = {
    vim.fn.glob(home .. "/.local/share/jdtls/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
};
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/jdtls/vscode-java-test/server/*.jar", 1), "\n"))
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/jdtls/pde/*.jar", 1), "\n"))

config['init_options'] = {
  bundles = bundles,
}

require('jdtls').start_or_attach(config)
