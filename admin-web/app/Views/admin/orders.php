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
        <button onclick="exportTableToCSV('orders_export.csv')" class="flex items-center gap-2 px-4 py-2 bg-surface-container-lowest border border-outline hover:bg-surface-container-low text-on-surface font-label-md text-label-md rounded-lg shadow-sm transition-all active:scale-[0.98] focus:outline-none focus:ring-2 focus:ring-primary/20">
            <span class="material-symbols-outlined text-[18px]">download</span>
            Export CSV
        </button>
        <button onclick="alert('Fitur Create Order sedang ditunda dan menunggu hasil konsultasi dengan tim.')" class="flex items-center gap-2 px-4 py-2 bg-surface-variant hover:bg-surface-variant/80 text-on-surface-variant font-label-md text-label-md rounded-lg shadow-sm transition-all active:scale-[0.98] focus:outline-none">
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
                <p class="font-display-lg text-display-lg text-on-background"><?= number_format($stats['totalOrders'] ?? 0, 0, ',', '.') ?></p>
            </div>
            <div class="w-12 h-12 rounded-full bg-surface-container-low flex items-center justify-center text-primary group-hover:scale-110 transition-transform">
                <span class="material-symbols-outlined" data-weight="fill" style="font-variation-settings: 'FILL' 1;">receipt_long</span>
            </div>
        </div>
        <!-- Stat Card 2 -->
        <div class="bg-surface-container-lowest rounded-xl p-5 shadow-[0_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/40 flex items-center justify-between group hover:shadow-[0_8px_30px_rgba(0,0,0,0.06)] transition-shadow">
            <div>
                <p class="font-label-md text-label-md text-on-surface-variant mb-1 uppercase tracking-wider">Pending</p>
                <p class="font-display-lg text-display-lg text-on-background"><?= number_format($stats['pendingOrders'] ?? 0, 0, ',', '.') ?></p>
            </div>
            <div class="w-12 h-12 rounded-full bg-tertiary-fixed/30 flex items-center justify-center text-tertiary group-hover:scale-110 transition-transform">
                <span class="material-symbols-outlined" data-weight="fill" style="font-variation-settings: 'FILL' 1;">pending_actions</span>
            </div>
        </div>
        <!-- Stat Card 3 -->
        <div class="bg-surface-container-lowest rounded-xl p-5 shadow-[0_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/40 flex items-center justify-between group hover:shadow-[0_8px_30px_rgba(0,0,0,0.06)] transition-shadow">
            <div>
                <p class="font-label-md text-label-md text-on-surface-variant mb-1 uppercase tracking-wider">Revenue Today</p>
                <p class="font-display-lg text-display-lg text-on-background">Rp <?= number_format($stats['revenueToday'] ?? 0, 0, ',', '.') ?></p>
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
            <div class="flex items-center gap-1 overflow-x-auto pb-2 sm:pb-0 hide-scrollbar w-full sm:w-auto" id="statusTabs">
                <button onclick="filterByStatus('all', this)" class="status-tab active px-4 py-2 rounded-full font-label-md text-label-md bg-secondary-container/20 text-primary font-bold transition-colors whitespace-nowrap">All Orders</button>
                <button onclick="filterByStatus('pending', this)" class="status-tab px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Pending</button>
                <button onclick="filterByStatus('processing', this)" class="status-tab px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Processing</button>
                <button onclick="filterByStatus('shipped', this)" class="status-tab px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Shipped</button>
                <button onclick="filterByStatus('delivered', this)" class="status-tab px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Delivered</button>
                <button onclick="filterByStatus('cancelled', this)" class="status-tab px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap">Cancelled</button>
            </div>
            
            <!-- Filters/Sort -->
            <div class="flex items-center gap-2">
                <div class="relative">
                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-[18px] text-on-surface-variant">search</span>
                    <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search orders..." class="pl-9 pr-4 py-1.5 rounded-lg border border-outline-variant bg-surface-container-lowest text-on-surface font-body-md focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary w-48 transition-all">
                </div>
                <div class="relative">
                    <button onclick="document.getElementById('sortMenu').classList.toggle('hidden')" class="flex items-center gap-2 px-3 py-1.5 rounded-lg border border-outline-variant hover:bg-surface-container-low text-on-surface font-label-md text-label-md transition-colors">
                        <span class="material-symbols-outlined text-[18px]">sort</span> Sort
                    </button>
                    <div id="sortMenu" class="hidden absolute right-0 mt-2 w-48 bg-surface-container-lowest border border-outline-variant rounded-lg shadow-lg py-1 z-10">
                        <button onclick="sortTable('date', 'desc')" class="w-full text-left px-4 py-2 text-label-md text-on-surface hover:bg-surface-container-low">Newest First</button>
                        <button onclick="sortTable('date', 'asc')" class="w-full text-left px-4 py-2 text-label-md text-on-surface hover:bg-surface-container-low">Oldest First</button>
                        <button onclick="sortTable('total', 'desc')" class="w-full text-left px-4 py-2 text-label-md text-on-surface hover:bg-surface-container-low">Highest Total</button>
                        <button onclick="sortTable('total', 'asc')" class="w-full text-left px-4 py-2 text-label-md text-on-surface hover:bg-surface-container-low">Lowest Total</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Table Wrapper -->
        <div class="overflow-x-auto w-full">
            <table class="w-full text-left border-collapse min-w-[900px]" id="ordersTable">
                <thead>
                    <tr class="bg-surface-container-lowest border-b border-outline-variant/60">
                        <th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold">Order ID</th>
                        <th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold">Customer</th>
                        <th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold">Date & Time</th>
                        <th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold text-right">Total</th>
                        <th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold">Status</th>
                        <th class="px-6 py-3 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider font-semibold text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-outline-variant/30 font-body-md text-body-md text-on-background">
                    <?php if (!empty($orders)): ?>
                        <?php foreach ($orders as $o): ?>
                            <tr class="table-row-hover order-row" data-status="<?= esc(strtolower($o['orderStatus'] ?? 'pending')) ?>" data-date="<?= strtotime($o['orderTime'] ?? 'now') ?>" data-total="<?= esc($o['totalPrice'] ?? 0) ?>">
                                <td class="px-6 py-4 whitespace-nowrap font-title-md text-title-md text-primary search-target">#<?= esc($o['invoiceCode'] ?? $o['orderId']) ?></td>
                                <td class="px-6 py-4 search-target">
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
                                <td class="px-6 py-4 whitespace-nowrap font-medium text-right" data-raw-total="<?= esc($o['totalPrice'] ?? 0) ?>">Rp <?= number_format($o['totalPrice'] ?? 0, 0, ',', '.') ?></td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full font-label-sm text-label-sm font-bold status-badge-<?= esc(strtolower($o['orderStatus'] ?? 'pending')) ?>">
                                        <?= esc(ucfirst($o['orderStatus'] ?? 'Pending')) ?>
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-right">
                                    <button onclick="openStatusModal('<?= esc($o['orderId']) ?>', '<?= esc($o['orderStatus'] ?? 'PENDING') ?>')" class="px-3 py-1.5 bg-primary/10 text-primary hover:bg-primary/20 rounded-lg font-label-md text-label-md transition-colors border border-transparent">Update Status</button>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr id="emptyRow"><td colspan="6" class="text-center py-8">No orders found.</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
        
        <!-- Pagination Footer -->
        <div id="ordersPagination" class="px-6 py-4 border-t border-outline-variant/50 flex items-center justify-between bg-surface-container-lowest">
            <!-- Will be populated by JS -->
        </div>
    </div>
</div>

<!-- Status Modal -->
<div id="statusModal" class="hidden fixed inset-0 bg-black/50 z-50 flex items-center justify-center">
    <div class="bg-surface rounded-xl shadow-lg w-full max-w-sm p-6">
        <h3 class="text-title-lg font-title-lg mb-4 text-on-surface">Update Order Status</h3>
        <form id="statusForm" action="" method="POST">
            <div class="mb-4">
                <label class="block text-label-md mb-1 text-on-surface-variant">Status</label>
                <select name="orderStatus" id="orderStatus" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                    <option value="PENDING">PENDING</option>
                    <option value="PROCESSING">PROCESSING</option>
                    <option value="SHIPPED">SHIPPED</option>
                    <option value="DELIVERED">DELIVERED</option>
                    <option value="CANCELLED">CANCELLED</option>
                </select>
            </div>
            <div class="flex justify-end gap-3 mt-6">
                <button type="button" onclick="closeStatusModal()" class="px-4 py-2 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-low transition-colors font-label-md">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-primary text-on-primary rounded-lg shadow-sm hover:shadow transition-shadow font-label-md">Update</button>
            </div>
        </form>
    </div>
</div>

<script>
// Initialize Pagination config
document.addEventListener("DOMContentLoaded", function() {
    const table = document.getElementById('ordersTable');
    table.dataset.paginationConfig = JSON.stringify({
        containerId: 'ordersPagination',
        rowsPerPage: 10,
        rowClass: '.order-row',
        itemType: 'orders'
    });
    // Trigger initial pagination
    setupPagination('ordersTable', 'ordersPagination', 10, '.order-row', 'orders');
});

// Modal Logic
function openStatusModal(id, currentStatus) {
    document.getElementById('orderStatus').value = currentStatus.toUpperCase();
    document.getElementById('statusForm').action = '<?= base_url('admin/orders/status/') ?>' + id;
    document.getElementById('statusModal').classList.remove('hidden');
}
function closeStatusModal() {
    document.getElementById('statusModal').classList.add('hidden');
}

// Filtering by Status
let currentStatusFilter = 'all';
function filterByStatus(status, btnElement) {
    currentStatusFilter = status;
    
    // Update active tab styling
    document.querySelectorAll('.status-tab').forEach(btn => {
        btn.className = 'status-tab px-4 py-2 rounded-full font-label-md text-label-md text-on-surface-variant hover:bg-surface-container-low transition-colors whitespace-nowrap';
    });
    btnElement.className = 'status-tab active px-4 py-2 rounded-full font-label-md text-label-md bg-secondary-container/20 text-primary font-bold transition-colors whitespace-nowrap';

    // Reset pagination to page 1 on filter change
    const table = document.getElementById('ordersTable');
    if (table) table.dataset.currentPage = 1;
    
    applyFilters();
}

// Search Filtering
function filterTable() {
    const table = document.getElementById('ordersTable');
    if (table) table.dataset.currentPage = 1;
    applyFilters();
}

function applyFilters() {
    const query = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.querySelectorAll('.order-row');
    
    rows.forEach(row => {
        const rowStatus = row.getAttribute('data-status');
        const textContent = row.innerText.toLowerCase();
        
        const matchesStatus = (currentStatusFilter === 'all' || rowStatus === currentStatusFilter);
        const matchesSearch = textContent.includes(query);
        
        if (matchesStatus && matchesSearch) {
            row.style.display = '';
            row.classList.remove('hidden-by-filter');
        } else {
            row.style.display = 'none';
            row.classList.add('hidden-by-filter');
        }
    });

    // Re-run pagination on the filtered results
    setupPagination('ordersTable', 'ordersPagination', 10, '.order-row', 'orders');
}

// Sorting logic
function sortTable(type, order) {
    document.getElementById('sortMenu').classList.add('hidden');
    const tbody = document.querySelector('#ordersTable tbody');
    const rows = Array.from(tbody.querySelectorAll('.order-row'));
    
    rows.sort((a, b) => {
        let valA = 0;
        let valB = 0;
        
        if (type === 'date') {
            valA = parseInt(a.getAttribute('data-date'));
            valB = parseInt(b.getAttribute('data-date'));
        } else if (type === 'total') {
            valA = parseFloat(a.getAttribute('data-total'));
            valB = parseFloat(b.getAttribute('data-total'));
        }
        
        if (order === 'asc') return valA - valB;
        if (order === 'desc') return valB - valA;
        return 0;
    });
    
    rows.forEach(row => tbody.appendChild(row));
    
    // Reset pagination to page 1
    const table = document.getElementById('ordersTable');
    if (table) table.dataset.currentPage = 1;
    setupPagination('ordersTable', 'ordersPagination', 10, '.order-row', 'orders');
}

// Close dropdowns on outside click
document.addEventListener('click', function(e) {
    if (!e.target.closest('button[onclick*="sortMenu"]')) {
        const sortMenu = document.getElementById('sortMenu');
        if (sortMenu) sortMenu.classList.add('hidden');
    }
});

// Export CSV Logic
function exportTableToCSV(filename) {
    const rows = document.querySelectorAll('#ordersTable tr');
    let csv = [];
    
    rows.forEach(row => {
        // Only export visible rows
        if (row.style.display !== 'none') {
            let rowData = [];
            const cols = row.querySelectorAll('th, td');
            
            // Skip the 'Actions' column which is the last one
            for (let i = 0; i < cols.length - 1; i++) {
                // Get clean text by removing inner HTML spacing
                let text = cols[i].innerText.replace(/(\r\n|\n|\r)/gm, " ").replace(/"/g, '""').trim();
                
                // For Total column, get the raw data attribute if it exists so it exports as number
                if (cols[i].hasAttribute('data-raw-total')) {
                    text = cols[i].getAttribute('data-raw-total');
                }
                
                rowData.push('"' + text + '"');
            }
            if (rowData.length > 0) csv.push(rowData.join(','));
        }
    });

    const csvFile = new Blob([csv.join('\n')], { type: 'text/csv' });
    const downloadLink = document.createElement("a");
    downloadLink.download = filename;
    downloadLink.href = window.URL.createObjectURL(csvFile);
    downloadLink.style.display = "none";
    document.body.appendChild(downloadLink);
    downloadLink.click();
    document.body.removeChild(downloadLink);
}
</script>
<?= $this->endSection() ?>
