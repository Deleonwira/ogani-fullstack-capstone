<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Delivery & Users<?= $this->endSection() ?>
<?= $this->section('content') ?>

<?php 
$totalAdmins = 0;
$totalCustomers = 0;
if (!empty($users)) {
    foreach ($users as $u) {
        if (($u['role'] ?? 'CUSTOMER') === 'ADMIN') {
            $totalAdmins++;
        } else {
            $totalCustomers++;
        }
    }
}
?>

<!-- Page Header & Tabs -->
<div class="mb-8 flex flex-col md:flex-row md:items-end justify-between gap-4">
    <div>
        <h2 class="font-headline-lg text-headline-lg text-on-surface mb-2">Delivery &amp; Users</h2>
        <p class="font-body-md text-body-md text-on-surface-variant">Manage your customer base and delivery fleet operations.</p>
    </div>
</div>

<!-- Tab Content: Customers -->
<div class="tab-content active" id="content-customers">
    <!-- Stats Row -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-component-gap mb-component-gap">
        <div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant/30 flex items-center gap-4">
            <div class="w-12 h-12 rounded-full bg-primary-container/20 flex items-center justify-center text-primary">
                <span class="material-symbols-outlined">admin_panel_settings</span>
            </div>
            <div>
                <p class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Total Admins</p>
                <p class="font-headline-md text-headline-md text-on-surface"><?= $totalAdmins ?></p>
            </div>
        </div>
        <div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant/30 flex items-center gap-4">
            <div class="w-12 h-12 rounded-full bg-secondary-container/20 flex items-center justify-center text-secondary">
                <span class="material-symbols-outlined">groups</span>
            </div>
            <div>
                <p class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Total Customers</p>
                <p class="font-headline-md text-headline-md text-on-surface"><?= $totalCustomers ?></p>
            </div>
        </div>
    </div>

    <!-- Customer Table Card -->
    <div class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant/50 overflow-hidden flex flex-col">
        <div class="p-4 border-b border-outline-variant/50 flex flex-col gap-4 bg-surface-bright">
            <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <h3 class="font-title-lg text-title-lg text-on-surface">User Directory</h3>
                <div class="flex items-center gap-2">
                    <div class="relative">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-[18px] text-on-surface-variant">search</span>
                        <input type="text" id="searchInput" onkeyup="filterUsers()" placeholder="Search users..." class="pl-9 pr-4 py-1.5 rounded-lg border border-outline-variant bg-surface-container-lowest text-on-surface font-body-md focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary w-48 sm:w-64 transition-all">
                    </div>
                </div>
            </div>
            <!-- Tabs -->
            <div class="flex gap-2 overflow-x-auto custom-scrollbar pb-2">
                <button onclick="filterByRole('all', this)" class="role-tab active px-4 py-2 rounded-full font-label-md text-label-md bg-secondary-container/20 text-primary font-bold transition-colors whitespace-nowrap">All Users</button>
                <button onclick="filterByRole('ADMIN', this)" class="role-tab px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Admins</button>
                <button onclick="filterByRole('CUSTOMER', this)" class="role-tab px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Customers</button>
            </div>
        </div>
        
        <div class="overflow-x-auto custom-scrollbar w-full">
            <table id="usersTable" class="w-full text-left border-collapse min-w-[800px]">
                <thead>
                    <tr class="bg-surface-container-low/50">
                        <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">User</th>
                        <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Email</th>
                        <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Total Orders</th>
                        <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Role</th>
                        <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Leaf Points</th>
                        <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50 text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-outline-variant/30">
                <?php if (!empty($users)): ?>
                    <?php foreach ($users as $u): ?>
                        <tr class="hover:bg-surface-container-lowest transition-colors group user-row" data-role="<?= esc($u['role'] ?? 'CUSTOMER') ?>">
                            <td class="py-4 px-6">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 rounded-full bg-secondary-container/30 flex items-center justify-center text-secondary font-title-md shrink-0">
                                        <?= esc(strtoupper(substr($u['fullName'] ?? $u['username'] ?? 'U', 0, 2))) ?>
                                    </div>
                                    <div>
                                        <p class="font-title-md text-title-md text-on-surface user-name"><?= esc($u['fullName'] ?? $u['username'] ?? 'Unknown') ?></p>
                                    </div>
                                </div>
                            </td>
                            <td class="py-4 px-6 font-body-md text-body-md text-on-surface-variant user-email"><?= esc($u['email'] ?? '') ?></td>
                            <td class="py-4 px-6 font-body-md text-body-md text-on-surface"><?= esc($u['totalOrders'] ?? 0) ?></td>
                            <td class="py-4 px-6 font-body-md text-body-md text-on-surface">
                                <?php if (($u['role'] ?? 'CUSTOMER') === 'ADMIN'): ?>
                                    <span class="px-2 py-1 bg-primary/10 text-primary rounded text-sm font-medium">ADMIN</span>
                                <?php else: ?>
                                    <span class="px-2 py-1 bg-surface-variant rounded text-sm text-on-surface-variant">CUSTOMER</span>
                                <?php endif; ?>
                            </td>
                            <td class="py-4 px-6">
                                <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-primary-container/10 text-primary font-label-md text-label-md border border-primary-container/20">
                                    <span class="material-symbols-outlined text-[14px]">energy_savings_leaf</span>
                                    <?= number_format($u['totalPoints'] ?? 0) ?>
                                </span>
                            </td>
                            <td class="py-4 px-6 text-right">
                                <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                    <button onclick="openRoleModal('<?= esc($u['userId']) ?>', '<?= esc($u['role'] ?? 'CUSTOMER') ?>')" class="p-2 text-on-surface-variant hover:text-primary hover:bg-primary-container/10 rounded-full transition-colors" title="Edit Role">
                                        <span class="material-symbols-outlined text-[20px]">manage_accounts</span>
                                    </button>
                                    <a href="<?= base_url('admin/users/delete/' . esc($u['userId'])) ?>" onclick="return confirm('Delete this user?')" class="p-2 text-on-surface-variant hover:text-error hover:bg-error-container/10 rounded-full transition-colors" title="Delete User">
                                        <span class="material-symbols-outlined text-[20px]">delete</span>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr><td colspan="6" class="text-center py-8">No users found.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div id="usersPagination" class="p-4 border-t border-outline-variant/50 flex items-center justify-between bg-surface-bright">
            <!-- Populated by JS -->
        </div>
    </div>
</div>

<!-- Role Modal -->
<div id="roleModal" class="hidden fixed inset-0 bg-black/50 z-50 flex items-center justify-center">
    <div class="bg-surface rounded-xl shadow-lg w-full max-w-sm p-6">
        <h3 class="text-title-lg font-title-lg mb-4 text-on-surface">Edit User</h3>
        <form id="roleForm" action="" method="POST">
            <div class="mb-4">
                <label class="block text-label-md mb-1 text-on-surface-variant">Role</label>
                <select name="role" id="userRole" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                    <option value="ADMIN">ADMIN</option>
                    <option value="CUSTOMER">CUSTOMER</option>
                </select>
            </div>
            <div class="mb-4">
                <label class="block text-label-md mb-1 text-on-surface-variant">New Password</label>
                <input type="password" name="password" id="userPassword" placeholder="Leave blank to keep current" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none">
            </div>
            <div class="flex justify-end gap-3 mt-6">
                <button type="button" onclick="closeRoleModal()" class="px-4 py-2 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-low transition-colors font-label-md">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-primary text-on-primary rounded-lg shadow-sm hover:shadow transition-shadow font-label-md">Save</button>
            </div>
        </form>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const table = document.getElementById('usersTable');
    if(table) {
        table.dataset.paginationConfig = JSON.stringify({
            containerId: 'usersPagination',
            rowsPerPage: 10,
            rowClass: '.user-row',
            itemType: 'users'
        });
        setupPagination('usersTable', 'usersPagination', 10, '.user-row', 'users');
    }
});

let currentRoleFilter = 'all';

function filterByRole(role, btnElement) {
    currentRoleFilter = role;
    
    // Update active tab styling
    document.querySelectorAll('.role-tab').forEach(btn => {
        btn.className = 'role-tab px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap';
    });
    btnElement.className = 'role-tab active px-4 py-2 rounded-full font-label-md text-label-md bg-secondary-container/20 text-primary font-bold transition-colors whitespace-nowrap';

    // Reset pagination to page 1 on filter change
    const table = document.getElementById('usersTable');
    if (table) table.dataset.currentPage = 1;
    
    applyFilters();
}

function filterUsers() {
    const table = document.getElementById('usersTable');
    if (table) table.dataset.currentPage = 1;
    applyFilters();
}

function applyFilters() {
    const query = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.querySelectorAll('.user-row');
    
    rows.forEach(row => {
        const name = row.querySelector('.user-name').innerText.toLowerCase();
        const email = row.querySelector('.user-email').innerText.toLowerCase();
        const rowRole = row.getAttribute('data-role');
        
        const matchesQuery = name.includes(query) || email.includes(query);
        const matchesRole = (currentRoleFilter === 'all' || rowRole === currentRoleFilter);
        
        if (matchesQuery && matchesRole) {
            row.style.display = '';
            row.classList.remove('hidden-by-filter');
        } else {
            row.style.display = 'none';
            row.classList.add('hidden-by-filter');
        }
    });

    setupPagination('usersTable', 'usersPagination', 10, '.user-row', 'users');
}

function openRoleModal(id, currentRole) {
    document.getElementById('userRole').value = currentRole.toUpperCase();
    document.getElementById('userPassword').value = '';
    document.getElementById('roleForm').action = '<?= base_url('admin/users/update/') ?>' + id;
    document.getElementById('roleModal').classList.remove('hidden');
}
function closeRoleModal() {
    document.getElementById('roleModal').classList.add('hidden');
}
</script>
<?= $this->endSection() ?>
