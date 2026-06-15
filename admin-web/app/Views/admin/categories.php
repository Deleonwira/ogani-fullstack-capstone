<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Categories<?= $this->endSection() ?>
<?= $this->section('content') ?>
<div class="mb-8 flex justify-between items-center">
    <div>
        <h2 class="font-headline-lg text-headline-lg text-on-surface">Categories</h2>
        <p class="font-body-md text-body-md text-on-surface-variant mt-1">Manage product categories.</p>
    </div>
    <button onclick="openModal()" class="bg-[#4CAF50] hover:bg-primary text-on-primary px-6 py-2.5 rounded-lg flex items-center gap-2">
        <span class="material-symbols-outlined" style="font-size: 20px;">add</span> Add Category
    </button>
</div>
<div class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant/50 overflow-hidden">
    <table class="w-full text-left border-collapse">
        <thead>
            <tr class="bg-surface-container-low/50">
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">ID</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Category Name</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Description</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50 text-right">Actions</th>
            </tr>
        </thead>
        <tbody class="divide-y divide-outline-variant/30">
        <?php if (!empty($categories)): ?>
            <?php foreach ($categories as $c): ?>
                <tr class="hover:bg-surface-container-lowest transition-colors group">
                    <td class="py-4 px-6"><?= esc($c['categoryId']) ?></td>
                    <td class="py-4 px-6 font-title-md flex items-center gap-4">
                        <?php if(!empty($c['image'])): ?>
                            <img src="<?= esc($c['image']) ?>" alt="<?= esc($c['categoryName']) ?>" class="w-12 h-12 rounded-lg object-cover bg-surface-variant">
                        <?php else: ?>
                            <div class="w-12 h-12 rounded-lg bg-surface-variant flex items-center justify-center text-on-surface-variant">
                                <span class="material-symbols-outlined">image</span>
                            </div>
                        <?php endif; ?>
                        <?= esc($c['categoryName']) ?>
                    </td>
                    <td class="py-4 px-6"><?= esc($c['description'] ?? '') ?></td>
                    <td class="py-4 px-6 text-right">
                        <button onclick="openModal('<?= esc($c['categoryId']) ?>', '<?= esc($c['categoryName']) ?>', '<?= esc($c['image'] ?? '') ?>')" class="text-primary hover:bg-primary-container/10 p-2 rounded-full"><span class="material-symbols-outlined">edit</span></button>
                        <a href="<?= base_url('admin/categories/delete/' . esc($c['categoryId'])) ?>" onclick="return confirm('Are you sure you want to delete this category?')" class="text-error hover:bg-error-container/10 p-2 rounded-full"><span class="material-symbols-outlined">delete</span></a>
                    </td>
                </tr>
            <?php endforeach; ?>
        <?php else: ?>
            <tr><td colspan="4" class="text-center py-8">No categories found.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div id="categoryModal" class="hidden fixed inset-0 bg-black/50 z-50 flex items-center justify-center">
    <div class="bg-surface rounded-xl shadow-lg w-full max-w-md p-6">
        <h3 id="modalTitle" class="text-title-lg font-title-lg mb-4 text-on-surface">Add Category</h3>
        <form action="<?= base_url('admin/categories/save') ?>" method="POST">
            <input type="hidden" name="id" id="categoryId">
            <div class="mb-4">
                <label class="block text-label-md mb-1 text-on-surface-variant">Category Name</label>
                <input type="text" name="categoryName" id="categoryName" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all" required>
            </div>
            <div class="mb-4">
                <label class="block text-label-md mb-1 text-on-surface-variant">Image URL</label>
                <input type="text" name="image" id="categoryImage" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all">
            </div>
            <div class="flex justify-end gap-3 mt-6">
                <button type="button" onclick="closeModal()" class="px-4 py-2 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-low transition-colors font-label-md">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-primary text-on-primary rounded-lg shadow-sm hover:shadow transition-shadow font-label-md">Save</button>
            </div>
        </form>
    </div>
</div>

<script>
function openModal(id = '', name = '', image = '') {
    document.getElementById('categoryId').value = id;
    document.getElementById('categoryName').value = name;
    document.getElementById('categoryImage').value = image;
    document.getElementById('modalTitle').innerText = id ? 'Edit Category' : 'Add Category';
    document.getElementById('categoryModal').classList.remove('hidden');
}
function closeModal() {
    document.getElementById('categoryModal').classList.add('hidden');
}
</script>
<?= $this->endSection() ?>
