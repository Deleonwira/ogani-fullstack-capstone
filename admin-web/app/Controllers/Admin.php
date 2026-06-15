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
    private function sendApiRequest($method, $endpoint, $body = null)
    {
        try {
            $client = \Config\Services::curlrequest();
            $options = [];
            if ($body !== null) {
                $options['json'] = $body;
            }
            $response = $client->request($method, 'http://localhost:8080/api/' . $endpoint, $options);
            $data = json_decode($response->getBody(), true);
            if (isset($data['success']) && $data['success'] == true) {
                return $data['data'] ?? true;
            }
            return false;
        } catch (\Exception $e) {
            return false;
        }
    }

    private function postApi($endpoint, $body)
    {
        return $this->sendApiRequest('POST', $endpoint, $body);
    }

    private function putApi($endpoint, $body)
    {
        return $this->sendApiRequest('PUT', $endpoint, $body);
    }

    private function deleteApi($endpoint)
    {
        return $this->sendApiRequest('DELETE', $endpoint);
    }
    public function index()
    {
        $stats = $this->fetchApi('dashboard/stats');
        return view('admin/dashboard', ['active_page' => 'dashboard', 'stats' => $stats]);
    }

    public function orders()
    {
        $stats = $this->fetchApi('dashboard/stats');
        $orders = $this->fetchApi('orders');
        return view('admin/orders', ['active_page' => 'orders', 'orders' => $orders, 'stats' => $stats]);
    }

    public function products()
    {
        $products = $this->fetchApi('products');
        $categories = $this->fetchApi('categories');
        return view('admin/products', ['active_page' => 'products', 'products' => $products, 'categories' => $categories]);
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

    public function saveProduct()
    {
        $id = $this->request->getPost('id');
        $data = [
            'productName' => $this->request->getPost('productName'),
            'price' => $this->request->getPost('price'),
            'stock' => $this->request->getPost('stock'),
            'description' => $this->request->getPost('description'),
            'unit' => $this->request->getPost('unit'),
            'weightPerUnit' => $this->request->getPost('weightPerUnit'),
            'productStatus' => $this->request->getPost('productStatus'),
            'productImage' => $this->request->getPost('productImage'),
            'category' => ['categoryId' => $this->request->getPost('categoryId')]
        ];

        if ($id) {
            $this->putApi('products/' . $id, $data);
        } else {
            $this->postApi('products', $data);
        }
        return redirect()->to('/admin/products');
    }

    public function deleteProduct($id)
    {
        $this->deleteApi('products/' . $id);
        return redirect()->to('/admin/products');
    }

    public function saveCategory()
    {
        $id = $this->request->getPost('id');
        $data = [
            'categoryName' => $this->request->getPost('categoryName'),
            'image' => $this->request->getPost('image')
        ];

        if ($id) {
            $this->putApi('categories/' . $id, $data);
        } else {
            $this->postApi('categories', $data);
        }
        return redirect()->to('/admin/categories');
    }

    public function deleteCategory($id)
    {
        $this->deleteApi('categories/' . $id);
        return redirect()->to('/admin/categories');
    }

    public function savePromo()
    {
        $id = $this->request->getPost('id');
        $data = [
            'promoCode' => $this->request->getPost('promoCode'),
            'title' => $this->request->getPost('title'),
            'description' => $this->request->getPost('description'),
            'discountValue' => $this->request->getPost('discountValue'),
            'minimumSpend' => $this->request->getPost('minimumSpend'),
            'expirationDate' => $this->request->getPost('expirationDate')
        ];

        if ($id) {
            $this->putApi('promos/' . $id, $data);
        } else {
            $this->postApi('promos', $data);
        }
        return redirect()->to('/admin/promos');
    }

    public function deletePromo($id)
    {
        $this->deleteApi('promos/' . $id);
        return redirect()->to('/admin/promos');
    }

    public function deleteReview($id)
    {
        $this->deleteApi('reviews/' . $id);
        return redirect()->to('/admin/reviews');
    }

    public function deleteUser($id)
    {
        $this->deleteApi('users/' . $id);
        return redirect()->to('/admin/users');
    }

    public function updateUserRole($id)
    {
        $role = $this->request->getPost('role');
        $this->putApi('users/' . $id . '/role', ['role' => $role]);
        return redirect()->to('/admin/users');
    }

    public function updateOrderStatus($id)
    {
        $status = $this->request->getPost('orderStatus');
        $this->putApi('orders/' . $id . '/status', ['orderStatus' => $status]);
        return redirect()->to('/admin/orders');
    }
}
