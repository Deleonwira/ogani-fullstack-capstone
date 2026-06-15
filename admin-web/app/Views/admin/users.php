<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Delivery & Users<?= $this->endSection() ?>
<?= $this->section('content') ?>
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
<div class="grid grid-cols-1 md:w-1/3 gap-component-gap mb-component-gap">
<div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant/30 flex items-center gap-4">
<div class="w-12 h-12 rounded-full bg-primary-container/20 flex items-center justify-center text-primary">
<span class="material-symbols-outlined">groups</span>
</div>
<div>
<p class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Total Customers</p>
<p class="font-headline-md text-headline-md text-on-surface">12,450</p>
</div>
</div>
</div>
<!-- Customer Table Card -->
<div class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant/50 overflow-hidden">
<div class="p-6 border-b border-outline-variant/50 flex justify-between items-center bg-surface-bright">
<h3 class="font-title-lg text-title-lg text-on-surface">Customer Directory</h3>
<button class="flex items-center gap-2 px-4 py-2 bg-surface border border-outline-variant rounded-lg font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors">
<span class="material-symbols-outlined text-sm">filter_list</span>
                        Filter
                    </button>
</div>
<div class="overflow-x-auto custom-scrollbar">
<table class="w-full text-left border-collapse">
<thead>
<tr class="bg-surface-container-low/50">
<th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Customer</th>
<th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Join Date</th>
<th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Total Orders</th>
<th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Role</th>
<th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Leaf Points</th>
<th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50 text-right">Actions</th>
</tr>
</thead>
<tbody class="divide-y divide-outline-variant/30">
<?php if (!empty($users)): ?>
    <?php foreach ($users as $u): ?>
        <tr class="hover:bg-surface-container-lowest transition-colors group">
            <td class="py-4 px-6">
                <div class="flex items-center gap-3">
                    <div class="w-10 h-10 rounded-full bg-secondary-container/30 flex items-center justify-center text-secondary font-title-md">
                        <?= esc(strtoupper(substr($u['fullName'] ?? $u['username'] ?? 'U', 0, 2))) ?>
                    </div>
                    <div>
                        <p class="font-title-md text-title-md text-on-surface"><?= esc($u['fullName'] ?? $u['username'] ?? 'Unknown') ?></p>
                        <p class="font-body-md text-body-md text-on-surface-variant text-sm"><?= esc($u['email'] ?? '') ?></p>
                    </div>
                </div>
            </td>
            <td class="py-4 px-6 font-body-md text-body-md text-on-surface-variant">-</td>
            <td class="py-4 px-6 font-body-md text-body-md text-on-surface"><?= esc($u['totalOrders'] ?? 0) ?></td>
            <td class="py-4 px-6 font-body-md text-body-md text-on-surface">
                <span class="px-2 py-1 bg-surface-variant rounded text-sm"><?= esc($u['role'] ?? 'CUSTOMER') ?></span>
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
    <tr><td colspan="5" class="text-center py-8">No users found.</td></tr>
<?php endif; ?>
</tbody>
</table>
</div>
<!-- Pagination -->
<div class="p-4 border-t border-outline-variant/50 flex items-center justify-between bg-surface-bright">
<span class="font-body-md text-body-md text-on-surface-variant">Showing 1-10 of 12,450</span>
<div class="flex gap-1">
<button class="p-1 rounded bg-surface border border-outline-variant text-on-surface-variant disabled:opacity-50" disabled=""><span class="material-symbols-outlined">chevron_left</span></button>
<button class="p-1 rounded bg-primary text-on-primary"><span class="w-6 h-6 flex items-center justify-center font-label-md">1</span></button>
<button class="p-1 rounded bg-surface border border-outline-variant text-on-surface-variant hover:bg-surface-container-low"><span class="w-6 h-6 flex items-center justify-center font-label-md">2</span></button>
<button class="p-1 rounded bg-surface border border-outline-variant text-on-surface-variant hover:bg-surface-container-low"><span class="w-6 h-6 flex items-center justify-center font-label-md">3</span></button>
<button class="p-1 rounded bg-surface border border-outline-variant text-on-surface-variant hover:bg-surface-container-low"><span class="material-symbols-outlined">chevron_right</span></button>
</div>
</div>
</div>
</div>
</div>
</div>

<!-- Role Modal -->
<div id="roleModal" class="hidden fixed inset-0 bg-black/50 z-50 flex items-center justify-center">
    <div class="bg-surface rounded-xl shadow-lg w-full max-w-sm p-6">
        <h3 class="text-title-lg font-title-lg mb-4 text-on-surface">Edit User Role</h3>
        <form id="roleForm" action="" method="POST">
            <div class="mb-4">
                <label class="block text-label-md mb-1 text-on-surface-variant">Role</label>
                <select name="role" id="userRole" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                    <option value="ADMIN">ADMIN</option>
                    <option value="CUSTOMER">CUSTOMER</option>
                </select>
            </div>
            <div class="flex justify-end gap-3 mt-6">
                <button type="button" onclick="closeRoleModal()" class="px-4 py-2 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-low transition-colors font-label-md">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-primary text-on-primary rounded-lg shadow-sm hover:shadow transition-shadow font-label-md">Save</button>
            </div>
        </form>
    </div>
</div>

<script>
function openRoleModal(id, currentRole) {
    document.getElementById('userRole').value = currentRole.toUpperCase();
    document.getElementById('roleForm').action = '<?= base_url('admin/users/role/') ?>' + id;
    document.getElementById('roleModal').classList.remove('hidden');
}
function closeRoleModal() {
    document.getElementById('roleModal').classList.add('hidden');
}
</script>
<?= $this->endSection() ?>
