<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Order Management<?= $this->endSection() ?>
<?= $this->section('content') ?>
<!-- Page Header -->
<div class="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-8">
<div>
<h2 class="font-headline-lg text-headline-lg text-on-background">Order Management</h2>
<p class="font-body-md text-body-md text-on-surface-variant mt-1">Review, manage, and process customer grocery orders.</p>
</div>
<div class="flex items-center gap-3">
<button class="flex items-center gap-2 px-4 py-2 bg-surface-container-lowest border border-outline hover:bg-surface-container-low text-on-surface font-label-md text-label-md rounded-lg shadow-sm transition-all active:scale-[0.98] focus:outline-none focus:ring-2 focus:ring-primary/20">
<span class="material-symbols-outlined text-[18px]">download</span>
                        Export CSV
                    </button>
<button class="flex items-center gap-2 px-4 py-2 bg-primary hover:bg-surface-tint text-on-primary font-label-md text-label-md rounded-lg shadow-sm shadow-primary/20 transition-all active:scale-[0.98] focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2">
<span class="material-symbols-outlined text-[18px]">add</span>
                        Create Order
                    </button>
</div>
</div>
<!-- Content Area: Bento Layout -->
<div class="grid grid-cols-12 gap-6">
<!-- Stats Overview (Bento Top Row) -->
<div class="col-span-12 grid grid-cols-1 md:grid-cols-3 gap-4">
<!-- Stat Card 1 -->
<div class="bg-surface-container-lowest rounded-xl p-5 shadow-[0_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/40 flex items-center justify-between group hover:shadow-[0_8px_30px_rgba(0,0,0,0.06)] transition-shadow">
<div>
<p class="font-label-md text-label-md text-on-surface-variant mb-1 uppercase tracking-wider">Total Orders</p>
<p class="font-display-lg text-display-lg text-on-background">1,284</p>
<p class="font-label-sm text-label-sm text-primary flex items-center gap-1 mt-1">
<span class="material-symbols-outlined text-[14px]">trending_up</span> +12% this week
                            </p>
</div>
<div class="w-12 h-12 rounded-full bg-surface-container-low flex items-center justify-center text-primary group-hover:scale-110 transition-transform">
<span class="material-symbols-outlined" data-weight="fill" style="font-variation-settings: 'FILL' 1;">receipt_long</span>
</div>
</div>
<!-- Stat Card 2 -->
<div class="bg-surface-container-lowest rounded-xl p-5 shadow-[0_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/40 flex items-center justify-between group hover:shadow-[0_8px_30px_rgba(0,0,0,0.06)] transition-shadow">
<div>
<p class="font-label-md text-label-md text-on-surface-variant mb-1 uppercase tracking-wider">Pending</p>
<p class="font-display-lg text-display-lg text-on-background">42</p>
<p class="font-label-sm text-label-sm text-tertiary flex items-center gap-1 mt-1">Needs attention</p>
</div>
<div class="w-12 h-12 rounded-full bg-tertiary-fixed/30 flex items-center justify-center text-tertiary group-hover:scale-110 transition-transform">
<span class="material-symbols-outlined" data-weight="fill" style="font-variation-settings: 'FILL' 1;">pending_actions</span>
</div>
</div>
<!-- Stat Card 3 -->
<div class="bg-surface-container-lowest rounded-xl p-5 shadow-[0_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/40 flex items-center justify-between group hover:shadow-[0_8px_30px_rgba(0,0,0,0.06)] transition-shadow">
<div>
<p class="font-label-md text-label-md text-on-surface-variant mb-1 uppercase tracking-wider">Revenue Today</p>
<p class="font-display-lg text-display-lg text-on-background">$8,450</p>
<p class="font-label-sm text-label-sm text-primary flex items-center gap-1 mt-1">
<span class="material-symbols-outlined text-[14px]">trending_up</span> +5.2% vs yesterday
                            </p>
</div>
<div class="w-12 h-12 rounded-full bg-secondary-container/50 flex items-center justify-center text-secondary group-hover:scale-110 transition-transform">
<span class="material-symbols-outlined" data-weight="fill" style="font-variation-settings: 'FILL' 1;">payments</span>
</div>
</div>
</div>
<!-- Main Data Table Container -->
<div class="col-span-12 bg-surface-container-lowest rounded-xl shadow-[0_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/40 overflow-hidden flex flex-col">
<!-- Table Header / Toolbar -->
<div class="px-6 py-4 border-b border-outline-variant/50 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 bg-surface-container-lowest">
<!-- Tabs -->
<div class="flex items-center gap-1 overflow-x-auto pb-2 sm:pb-0 hide-scrollbar w-full sm:w-auto">
<button class="px-4 py-2 rounded-full font-label-md text-label-md bg-secondary-container/20 text-primary font-bold transition-colors whitespace-nowrap">All Orders</button>
<button class="px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Pending</button>
<button class="px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Processing</button>
<button class="px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Shipped</button>
<button class="px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Delivered</button>
<button class="px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Cancelled</button>
</div>
<!-- Filters/Sort -->
<div class="flex items-center gap-2">
<button class="flex items-center gap-2 px-3 py-1.5 rounded-lg border border-outline-variant hover:bg-surface-container-low text-on-surface font-label-md text-label-md transition-colors">
<span class="material-symbols-outlined text-[18px]">filter_list</span>
                                Filter
                            </button>
<button class="flex items-center gap-2 px-3 py-1.5 rounded-lg border border-outline-variant hover:bg-surface-container-low text-on-surface font-label-md text-label-md transition-colors">
<span class="material-symbols-outlined text-[18px]">sort</span>
                                Sort
                            </button>
</div>
</div>
<!-- Table Wrapper -->
<div class="overflow-x-auto w-full">
<table class="w-full text-left border-collapse min-w-[900px]">
<thead>
<tr class="bg-surface-container-lowest border-b border-outline-variant/60">
<th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold">Order ID</th>
<th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold">Customer</th>
<th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold">Date &amp; Time</th>
<th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold">Items</th>
<th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold text-right">Total</th>
<th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold">Payment</th>
<th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold">Status</th>
<th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold text-right">Actions</th>
</tr>
</thead>
<tbody class="divide-y divide-outline-variant/30 font-body-md text-body-md text-on-background">
<?php if (!empty($orders)): ?>
    <?php foreach ($orders as $o): ?>
        <tr class="table-row-hover">
            <td class="px-6 py-4 whitespace-nowrap font-title-md text-title-md text-primary">#<?= esc($o['invoiceCode'] ?? $o['orderId']) ?></td>
            <td class="px-6 py-4">
                <div class="flex items-center gap-3">
                    <div class="w-8 h-8 rounded-full bg-surface-variant text-on-surface flex items-center justify-center font-bold text-sm shrink-0">
                        <?= esc(strtoupper(substr($o['user']['fullName'] ?? $o['user']['username'] ?? 'U', 0, 2))) ?>
                    </div>
                    <div>
                        <p class="font-medium"><?= esc($o['user']['fullName'] ?? $o['user']['username'] ?? 'Unknown User') ?></p>
                        <p class="text-label-sm text-on-surface-variant"><?= esc($o['user']['email'] ?? '') ?></p>
                    </div>
                </div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-on-surface-variant">
                <div><?= esc(date('M d, Y', strtotime($o['orderTime'] ?? 'now'))) ?></div>
                <div class="text-label-sm"><?= esc(date('h:i A', strtotime($o['orderTime'] ?? 'now'))) ?></div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-on-surface-variant">- items</td>
            <td class="px-6 py-4 whitespace-nowrap font-medium text-right">$<?= number_format($o['totalPrice'] ?? 0, 2) ?></td>
            <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center gap-1.5 text-primary">
                    <span class="material-symbols-outlined text-[16px]">check_circle</span>
                    <span>Paid</span>
                </div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full font-label-sm text-label-sm font-bold status-badge-<?= esc(strtolower($o['orderStatus'] ?? 'pending')) ?>">
                    <?= esc(ucfirst($o['orderStatus'] ?? 'Pending')) ?>
                </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-right">
                <button class="px-3 py-1.5 text-primary hover:bg-primary/10 rounded-lg font-label-md text-label-md transition-colors border border-transparent hover:border-primary/20">View Details</button>
            </td>
        </tr>
    <?php endforeach; ?>
<?php else: ?>
    <tr><td colspan="8" class="text-center py-8">No orders found.</td></tr>
<?php endif; ?>
</tbody>
</table>
</div>
<!-- Pagination Footer -->
<div class="px-6 py-4 border-t border-outline-variant/50 bg-surface-container-lowest flex items-center justify-between">
<p class="text-label-sm text-on-surface-variant">Showing 1 to 5 of 1,284 entries</p>
<div class="flex items-center gap-2">
<button class="w-8 h-8 rounded border border-outline-variant flex items-center justify-center text-on-surface-variant hover:bg-surface-container-low disabled:opacity-50" disabled="">
<span class="material-symbols-outlined text-[18px]">chevron_left</span>
</button>
<button class="w-8 h-8 rounded border border-primary bg-primary text-on-primary flex items-center justify-center font-label-md text-label-md">1</button>
<button class="w-8 h-8 rounded border border-outline-variant flex items-center justify-center text-on-surface hover:bg-surface-container-low font-label-md text-label-md transition-colors">2</button>
<button class="w-8 h-8 rounded border border-outline-variant flex items-center justify-center text-on-surface hover:bg-surface-container-low font-label-md text-label-md transition-colors">3</button>
<span class="text-on-surface-variant mx-1">...</span>
<button class="w-8 h-8 rounded border border-outline-variant flex items-center justify-center text-on-surface hover:bg-surface-container-low font-label-md text-label-md transition-colors">128</button>
<button class="w-8 h-8 rounded border border-outline-variant flex items-center justify-center text-on-surface hover:bg-surface-container-low transition-colors">
<span class="material-symbols-outlined text-[18px]">chevron_right</span>
</button>
</div>
</div>
</div>
</div>
<?= $this->endSection() ?>
