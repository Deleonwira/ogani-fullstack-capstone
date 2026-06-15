<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Product Inventory<?= $this->endSection() ?>
<?= $this->section('content') ?>
<!-- Page Header -->
<div class="flex justify-between items-center mb-8">
<div>
<h2 class="font-headline-lg text-headline-lg text-on-surface">Product Inventory</h2>
<p class="font-body-md text-body-md text-on-surface-variant mt-1">Manage your catalog, stock levels, and pricing.</p>
</div>
<button onclick="openModal()" class="bg-[#4CAF50] hover:bg-primary text-on-primary px-6 py-2.5 rounded-lg flex items-center gap-2 font-title-md text-title-md transition-colors shadow-sm">
<span class="material-symbols-outlined" style="font-size: 20px;">add</span>
                Add New Product
            </button>
</div>
<!-- Filter & Action Bar -->
<div class="bg-surface-container-lowest rounded-xl p-4 shadow-[0_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/30 mb-6 flex flex-wrap gap-4 items-center justify-between">
<div class="flex flex-wrap gap-4 flex-1">
<div class="relative w-full max-w-xs">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant" style="font-size: 20px;">search</span>
<input class="w-full pl-10 pr-4 py-2 bg-surface rounded-lg border border-outline-variant focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all font-body-md text-body-md text-on-surface placeholder:text-outline" placeholder="Search by name, SKU..." type="text"/>
</div>
<select class="py-2 pl-4 pr-10 bg-surface rounded-lg border border-outline-variant focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all font-body-md text-body-md text-on-surface appearance-none bg-no-repeat" style="background-image: url('data:image/svg+xml;utf8,&lt;svg xmlns=\'http://www.w3.org/2000/svg\' width=\'16\' height=\'16\' fill=\'%236f7a6b\' viewBox=\'0 0 16 16\'&gt;&lt;path d=\'M3.204 5h9.592L8 10.481 3.204 5z\'/&gt;&lt;/svg&gt;'); background-position: right 12px center;">
<option value="">All Categories</option>
<option value="fruits">Fresh Fruits</option>
<option value="vegetables">Vegetables</option>
<option value="dairy">Dairy &amp; Eggs</option>
<option value="bakery">Bakery</option>
</select>
<select class="py-2 pl-4 pr-10 bg-surface rounded-lg border border-outline-variant focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all font-body-md text-body-md text-on-surface appearance-none bg-no-repeat" style="background-image: url('data:image/svg+xml;utf8,&lt;svg xmlns=\'http://www.w3.org/2000/svg\' width=\'16\' height=\'16\' fill=\'%236f7a6b\' viewBox=\'0 0 16 16\'&gt;&lt;path d=\'M3.204 5h9.592L8 10.481 3.204 5z\'/&gt;&lt;/svg&gt;'); background-position: right 12px center;">
<option value="">Status: All</option>
<option value="in-stock">In Stock</option>
<option value="low-stock">Low Stock</option>
<option value="out-of-stock">Out of Stock</option>
</select>
</div>
<button class="flex items-center gap-2 text-on-surface-variant border border-outline-variant px-4 py-2 rounded-lg hover:bg-surface-container-low transition-colors font-label-md text-label-md">
<span class="material-symbols-outlined" style="font-size: 18px;">tune</span>
                More Filters
            </button>
</div>
<!-- Data Table Container -->
<div class="bg-surface-container-lowest rounded-xl shadow-[0_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/30 overflow-hidden">
<div class="overflow-x-auto">
<table class="w-full text-left border-collapse">
<thead>
<tr class="bg-surface-container-low/50 border-b border-outline-variant/50">
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant font-semibold tracking-wider">Product</th>
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant font-semibold tracking-wider">Category</th>
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant font-semibold tracking-wider">Price (Unit)</th>
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant font-semibold tracking-wider">Stock</th>
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant font-semibold tracking-wider">Status</th>
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant font-semibold tracking-wider text-right">Actions</th>
</tr>
</thead>
<tbody class="divide-y divide-outline-variant/30">
<?php if (!empty($products)): ?>
    <?php foreach ($products as $p): ?>
        <tr class="table-row-hover group transition-colors">
            <td class="py-4 px-6 flex items-center gap-4">
                <?php if(!empty($p['productImage'])): ?>
                    <img src="<?= esc($p['productImage']) ?>" alt="<?= esc($p['productName']) ?>" class="w-12 h-12 rounded-lg object-cover bg-surface-variant">
                <?php else: ?>
                    <div class="w-12 h-12 rounded-lg bg-surface-variant flex items-center justify-center text-on-surface-variant">
                        <span class="material-symbols-outlined">image</span>
                    </div>
                <?php endif; ?>
                <div>
                    <p class="font-title-md text-title-md text-on-surface"><?= esc($p['productName'] ?? 'Unknown') ?></p>
                    <p class="font-label-sm text-label-sm text-outline">ID: <?= esc($p['productId'] ?? '') ?></p>
                </div>
            </td>
            <td class="py-4 px-6 font-body-md text-body-md text-on-surface-variant"><?= esc($p['category']['categoryName'] ?? 'Uncategorized') ?></td>
            <td class="py-4 px-6 font-body-md text-body-md text-on-surface font-medium">Rp <?= number_format($p['price'] ?? 0, 0, ',', '.') ?></td>
            <td class="py-4 px-6 font-body-md text-body-md text-on-surface"><?= esc($p['stock'] ?? 0) ?></td>
            <td class="py-4 px-6">
                <?php if (($p['stock'] ?? 0) > 0): ?>
                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full font-label-sm text-label-sm bg-primary-container/10 text-primary">In Stock</span>
                <?php else: ?>
                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full font-label-sm text-label-sm bg-error-container text-on-error-container">Out of Stock</span>
                <?php endif; ?>
            </td>
            <td class="py-4 px-6 text-right">
                <div class="flex items-center justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                    <button onclick="openModal('<?= esc($p['productId']) ?>', '<?= esc($p['productName']) ?>', '<?= esc($p['price']) ?>', '<?= esc($p['stock']) ?>', '<?= esc($p['category']['categoryId'] ?? '') ?>', '<?= esc($p['productImage'] ?? '') ?>')" aria-label="Edit" class="text-on-surface-variant hover:text-primary p-1 rounded transition-colors">
                        <span class="material-symbols-outlined" style="font-size: 20px;">edit</span>
                    </button>
                    <a href="<?= base_url('admin/products/delete/' . esc($p['productId'])) ?>" onclick="return confirm('Delete this product?')" aria-label="Delete" class="text-on-surface-variant hover:text-error p-1 rounded transition-colors">
                        <span class="material-symbols-outlined" style="font-size: 20px;">delete</span>
                    </a>
                </div>
            </td>
        </tr>
    <?php endforeach; ?>
<?php else: ?>
    <tr><td colspan="6" class="text-center py-8 text-on-surface-variant">No products found.</td></tr>
<?php endif; ?>
</tbody>
</table>
</div>
<!-- Pagination Footer -->
<div class="px-6 py-4 border-t border-outline-variant/30 flex items-center justify-between bg-surface-container-lowest">
<div class="font-body-md text-body-md text-on-surface-variant">
                    Showing <span class="font-medium text-on-surface">1</span> to <span class="font-medium text-on-surface">10</span> of <span class="font-medium text-on-surface">1,240</span> products
                </div>
<div class="flex gap-1">
<button class="p-2 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-low disabled:opacity-50 disabled:cursor-not-allowed transition-colors" disabled="">
<span class="material-symbols-outlined" style="font-size: 20px;">chevron_left</span>
</button>
<button class="w-10 h-10 border border-primary bg-primary-container/10 text-primary rounded-lg font-title-md text-title-md hover:bg-primary-container/20 transition-colors">1</button>
<button class="w-10 h-10 border border-outline-variant text-on-surface-variant rounded-lg font-title-md text-title-md hover:bg-surface-container-low transition-colors">2</button>
<button class="w-10 h-10 border border-outline-variant text-on-surface-variant rounded-lg font-title-md text-title-md hover:bg-surface-container-low transition-colors">3</button>
<span class="w-10 h-10 flex items-center justify-center text-on-surface-variant">...</span>
<button class="w-10 h-10 border border-outline-variant text-on-surface-variant rounded-lg font-title-md text-title-md hover:bg-surface-container-low transition-colors">124</button>
<button class="p-2 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-low transition-colors">
<span class="material-symbols-outlined" style="font-size: 20px;">chevron_right</span>
</button>
</div>
</div>
</div>

<!-- Modal -->
<div id="productModal" class="hidden fixed inset-0 bg-black/50 z-50 flex items-center justify-center overflow-y-auto">
    <div class="bg-surface rounded-xl shadow-lg w-full max-w-2xl p-6 m-4 mt-20">
        <h3 id="modalTitle" class="text-title-lg font-title-lg mb-4 text-on-surface">Add Product</h3>
        <form action="<?= base_url('admin/products/save') ?>" method="POST">
            <input type="hidden" name="id" id="productId">
            <div class="grid grid-cols-2 gap-4">
                <div class="mb-4 col-span-2">
                    <label class="block text-label-md mb-1 text-on-surface-variant">Product Name</label>
                    <input type="text" name="productName" id="productName" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                </div>
                <div class="mb-4">
                    <label class="block text-label-md mb-1 text-on-surface-variant">Price (Rp)</label>
                    <input type="number" name="price" id="price" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                </div>
                <div class="mb-4">
                    <label class="block text-label-md mb-1 text-on-surface-variant">Stock</label>
                    <input type="number" name="stock" id="stock" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                </div>
                <div class="mb-4 col-span-2">
                    <label class="block text-label-md mb-1 text-on-surface-variant">Category</label>
                    <select name="categoryId" id="categoryId" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                        <option value="">Select Category</option>
                        <?php if(!empty($categories)): foreach($categories as $c): ?>
                            <option value="<?= esc($c['categoryId']) ?>"><?= esc($c['categoryName']) ?></option>
                        <?php endforeach; endif; ?>
                    </select>
                </div>
                <div class="mb-4 col-span-2">
                    <label class="block text-label-md mb-1 text-on-surface-variant">Image URL</label>
                    <input type="text" name="productImage" id="productImage" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none">
                </div>
            </div>
            <div class="flex justify-end gap-3 mt-6">
                <button type="button" onclick="closeModal()" class="px-4 py-2 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-low transition-colors font-label-md">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-primary text-on-primary rounded-lg shadow-sm hover:shadow transition-shadow font-label-md">Save</button>
            </div>
        </form>
    </div>
</div>

<script>
function openModal(id = '', name = '', price = '', stock = '', categoryId = '', image = '') {
    document.getElementById('productId').value = id;
    document.getElementById('productName').value = name;
    document.getElementById('price').value = price;
    document.getElementById('stock').value = stock;
    document.getElementById('categoryId').value = categoryId;
    document.getElementById('productImage').value = image;
    document.getElementById('modalTitle').innerText = id ? 'Edit Product' : 'Add Product';
    document.getElementById('productModal').classList.remove('hidden');
}
function closeModal() {
    document.getElementById('productModal').classList.add('hidden');
}
</script>
<?= $this->endSection() ?>
