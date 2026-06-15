<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Dashboard Overview<?= $this->endSection() ?>
<?= $this->section('content') ?>
<!-- Page Header -->
<div class="mb-8 flex justify-between items-end">
<div>
<h2 class="font-headline-lg text-headline-lg text-on-surface">Dashboard Overview</h2>
<p class="font-body-md text-body-md text-on-surface-variant mt-1">Welcome back. Here's what's happening today.</p>
</div>
<div class="flex gap-3">
<button class="flex items-center gap-2 px-4 py-2 bg-surface-container-lowest border border-outline-variant rounded-lg font-label-md text-label-md text-on-surface hover:bg-surface-container-low transition-colors shadow-sm">
<span class="material-symbols-outlined text-[18px]">calendar_month</span>
                    Last 30 Days
                </button>
<button class="flex items-center gap-2 px-4 py-2 bg-primary text-on-primary rounded-lg font-label-md text-label-md hover:bg-surface-tint transition-colors shadow-sm">
<span class="material-symbols-outlined text-[18px]">download</span>
                    Export Report
                </button>
</div>
</div>
<!-- Metrics Row -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
<!-- Metric 1 -->
<div class="bg-surface-container-lowest rounded-xl p-6 shadow-[0px_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/30 flex flex-col justify-between">
<div class="flex justify-between items-start mb-4">
<div class="p-2 bg-primary-container/20 text-primary rounded-lg">
<span class="material-symbols-outlined">payments</span>
</div>
<span class="flex items-center text-secondary font-label-md text-label-md bg-secondary-container/30 px-2 py-1 rounded-full">
<span class="material-symbols-outlined text-[14px] mr-1">trending_up</span>
                        +12%
                    </span>
</div>
<div>
<p class="font-label-md text-label-md text-on-surface-variant uppercase tracking-wider mb-1">Total Revenue</p>
<h3 class="font-headline-lg text-headline-lg text-on-surface">$<?= number_format($stats['revenueToday'] ?? 0, 2) ?></h3>
</div>
</div>
<!-- Metric 2 -->
<div class="bg-surface-container-lowest rounded-xl p-6 shadow-[0px_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/30 flex flex-col justify-between">
<div class="flex justify-between items-start mb-4">
<div class="p-2 bg-tertiary-container/20 text-tertiary rounded-lg">
<span class="material-symbols-outlined">shopping_bag</span>
</div>
<span class="flex items-center text-secondary font-label-md text-label-md bg-secondary-container/30 px-2 py-1 rounded-full">
<span class="material-symbols-outlined text-[14px] mr-1">trending_up</span>
                        +5%
                    </span>
</div>
<div>
<p class="font-label-md text-label-md text-on-surface-variant uppercase tracking-wider mb-1">Active Orders</p>
<h3 class="font-headline-lg text-headline-lg text-on-surface"><?= $stats['pendingOrders'] ?? 0 ?></h3>
</div>
</div>
<!-- Metric 3 -->
<div class="bg-surface-container-lowest rounded-xl p-6 shadow-[0px_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/30 flex flex-col justify-between">
<div class="flex justify-between items-start mb-4">
<div class="p-2 bg-surface-variant text-on-surface-variant rounded-lg">
<span class="material-symbols-outlined">inventory_2</span>
</div>
<span class="flex items-center text-on-surface-variant font-label-md text-label-md bg-surface-container-low px-2 py-1 rounded-full">
                        All Time
                    </span>
</div>
<div>
<p class="font-label-md text-label-md text-on-surface-variant uppercase tracking-wider mb-1">Total Products</p>
<h3 class="font-headline-lg text-headline-lg text-on-surface"><?= number_format($stats['totalProducts'] ?? 0) ?></h3>
</div>
</div>
</div>
<!-- Chart Section -->
<div class="bg-surface-container-lowest rounded-xl p-6 shadow-[0px_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/30 mb-8">
<div class="flex justify-between items-center mb-6">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface">Sales Overview</h3>
<p class="font-label-sm text-label-sm text-on-surface-variant mt-1">Monthly revenue trends across all platforms</p>
</div>
<div class="flex gap-2">
<span class="inline-flex items-center gap-1.5 font-label-sm text-label-sm"><span class="w-2 h-2 rounded-full bg-primary"></span> Organic</span>
<span class="inline-flex items-center gap-1.5 font-label-sm text-label-sm ml-3"><span class="w-2 h-2 rounded-full bg-tertiary-container"></span> B2B</span>
</div>
</div>
<div class="w-full h-[300px] relative">
<canvas id="salesChart"></canvas>
</div>
</div>
<!-- Recent Orders Table -->
<div class="bg-surface-container-lowest rounded-xl shadow-[0px_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/30 overflow-hidden">
<div class="p-6 border-b border-outline-variant/50 flex justify-between items-center">
<h3 class="font-title-lg text-title-lg text-on-surface">Recent Orders</h3>
<button class="font-label-md text-label-md text-primary hover:underline">View All</button>
</div>
<div class="overflow-x-auto custom-scrollbar">
<table class="w-full text-left border-collapse">
<thead>
<tr class="bg-surface-container-low/50">
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold border-b border-outline-variant/50">Order ID</th>
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold border-b border-outline-variant/50">Customer</th>
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold border-b border-outline-variant/50">Date</th>
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold border-b border-outline-variant/50">Total</th>
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold border-b border-outline-variant/50">Status</th>
<th class="py-3 px-6 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold border-b border-outline-variant/50 text-right">Actions</th>
</tr>
</thead>
<tbody class="divide-y divide-outline-variant/30">
<tr class="hover:bg-surface-container-lowest transition-colors group">
<td class="py-4 px-6 font-body-md text-body-md text-on-surface font-medium">#ORD-001</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface">
<div class="flex items-center gap-3">
<div class="w-8 h-8 rounded-full bg-surface-container-high flex items-center justify-center text-xs font-bold text-on-surface">JD</div>
                                    John Doe
                                </div>
</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface-variant">Oct 24, 2023</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface font-medium">$124.50</td>
<td class="py-4 px-6">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-tertiary-container/10 text-tertiary">
                                    Pending
                                </span>
</td>
<td class="py-4 px-6 text-right">
<button class="text-on-surface-variant hover:text-primary transition-colors opacity-0 group-hover:opacity-100">
<span class="material-symbols-outlined text-[20px]">more_vert</span>
</button>
</td>
</tr>
<tr class="hover:bg-surface-container-lowest transition-colors group">
<td class="py-4 px-6 font-body-md text-body-md text-on-surface font-medium">#ORD-002</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface">
<div class="flex items-center gap-3">
<div class="w-8 h-8 rounded-full bg-surface-container-high flex items-center justify-center text-xs font-bold text-on-surface">AS</div>
                                    Alice Smith
                                </div>
</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface-variant">Oct 24, 2023</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface font-medium">$89.00</td>
<td class="py-4 px-6">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-surface-variant text-on-surface-variant">
                                    Shipped
                                </span>
</td>
<td class="py-4 px-6 text-right">
<button class="text-on-surface-variant hover:text-primary transition-colors opacity-0 group-hover:opacity-100">
<span class="material-symbols-outlined text-[20px]">more_vert</span>
</button>
</td>
</tr>
<tr class="hover:bg-surface-container-lowest transition-colors group">
<td class="py-4 px-6 font-body-md text-body-md text-on-surface font-medium">#ORD-003</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface">
<div class="flex items-center gap-3">
<div class="w-8 h-8 rounded-full bg-surface-container-high flex items-center justify-center text-xs font-bold text-on-surface">MJ</div>
                                    Michael Johnson
                                </div>
</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface-variant">Oct 23, 2023</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface font-medium">$210.75</td>
<td class="py-4 px-6">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-primary-container/20 text-secondary">
                                    Delivered
                                </span>
</td>
<td class="py-4 px-6 text-right">
<button class="text-on-surface-variant hover:text-primary transition-colors opacity-0 group-hover:opacity-100">
<span class="material-symbols-outlined text-[20px]">more_vert</span>
</button>
</td>
</tr>
<tr class="hover:bg-surface-container-lowest transition-colors group">
<td class="py-4 px-6 font-body-md text-body-md text-on-surface font-medium">#ORD-004</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface">
<div class="flex items-center gap-3">
<div class="w-8 h-8 rounded-full bg-surface-container-high flex items-center justify-center text-xs font-bold text-on-surface">EW</div>
                                    Emma Wilson
                                </div>
</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface-variant">Oct 23, 2023</td>
<td class="py-4 px-6 font-body-md text-body-md text-on-surface font-medium">$45.20</td>
<td class="py-4 px-6">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-primary-container/20 text-secondary">
                                    Delivered
                                </span>
</td>
<td class="py-4 px-6 text-right">
<button class="text-on-surface-variant hover:text-primary transition-colors opacity-0 group-hover:opacity-100">
<span class="material-symbols-outlined text-[20px]">more_vert</span>
</button>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<?= $this->endSection() ?>
