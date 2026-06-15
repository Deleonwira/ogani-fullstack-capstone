<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Categories<?= $this->endSection() ?>
<?= $this->section('content') ?>
<div class="mb-8 flex justify-between items-center">
    <div>
        <h2 class="font-headline-lg text-headline-lg text-on-surface">Categories</h2>
        <p class="font-body-md text-body-md text-on-surface-variant mt-1">Manage product categories.</p>
    </div>
    <button class="bg-[#4CAF50] hover:bg-primary text-on-primary px-6 py-2.5 rounded-lg flex items-center gap-2">
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
                    <td class="py-4 px-6 font-title-md"><?= esc($c['categoryName']) ?></td>
                    <td class="py-4 px-6"><?= esc($c['description'] ?? '') ?></td>
                    <td class="py-4 px-6 text-right">
                        <button class="text-primary hover:bg-primary-container/10 p-2 rounded-full"><span class="material-symbols-outlined">edit</span></button>
                    </td>
                </tr>
            <?php endforeach; ?>
        <?php else: ?>
            <tr><td colspan="4" class="text-center py-8">No categories found.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
</div>
<?= $this->endSection() ?>
