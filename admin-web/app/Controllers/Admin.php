<?php

namespace App\Controllers;

class Admin extends BaseController
{
    private function fetchApi($endpoint)
    {
        try {
            $client = \Config\Services::curlrequest();
            $response = $client->request('GET', 'http://localhost:8080/api/' . $endpoint);
            $data = json_decode($response->getBody(), true);
            if (isset($data['success']) && $data['success'] == true) {
                return $data['data'];
            }
            return [];
        } catch (\Exception $e) {
            return [];
        }
    }

    public function index()
    {
        $stats = $this->fetchApi('dashboard/stats');
        return view('admin/dashboard', ['active_page' => 'dashboard', 'stats' => $stats]);
    }

    public function orders()
    {
        $orders = $this->fetchApi('orders');
        return view('admin/orders', ['active_page' => 'orders', 'orders' => $orders]);
    }

    public function products()
    {
        $products = $this->fetchApi('products');
        return view('admin/products', ['active_page' => 'products', 'products' => $products]);
    }

    public function users()
    {
        $users = $this->fetchApi('users');
        return view('admin/users', ['active_page' => 'users', 'users' => $users]);
    }

    public function categories()
    {
        $categories = $this->fetchApi('categories');
        return view('admin/categories', ['active_page' => 'categories', 'categories' => $categories]);
    }

    public function promos()
    {
        $promos = $this->fetchApi('promos');
        return view('admin/promos', ['active_page' => 'promos', 'promos' => $promos]);
    }

    public function reviews()
    {
        $reviews = $this->fetchApi('reviews');
        return view('admin/reviews', ['active_page' => 'reviews', 'reviews' => $reviews]);
    }
}
