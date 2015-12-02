<?php

require_once('View.php');

class IndexView extends View {
    
    public $modules_dir = 'view/';
    
    public function __construct() {
        parent::__construct();
    }
    
    public function fetch() {
        
        if($this->request->method('post') && $this->request->post('callback')) {
            $callback->phone        = $this->request->post('phone');
            $callback->name         = $this->request->post('name');
            //$callback->message      = $this->request->post('message');
            $callback->message      = "___";
            //$callback->name         = "no_name";
            
            $this->design->assign('callname',  $callback->name);
            $this->design->assign('callemail', $callback->phone);
            $this->design->assign('callmessage', $callback->message);
            $this->design->assign('call_sent', true);
            $callback_id = $this->callbacks->add_callback($callback);
            // Отправляем email
            $this->callbacks->email_callback_admin($callback_id);
        }
        
        // E-mail подписка
        if ($this->request->post('subscribe')) {
            $email = $this->request->post('subscribe_email');
            $this->db->query("select count(id) as cnt from __subscribe_mailing where email=?", $email);
            $cnt = $this->db->result('cnt');
            if (empty($email)) {
                $this->design->assign('subscribe_error', 'empty_email');
            } elseif ($cnt > 0) {
                $this->design->assign('subscribe_error', 'email_exist');
            } else {
                $this->db->query("insert into __subscribe_mailing set email=?", $email);
                $this->design->assign('subscribe_success', '1');
            }
        }
        
        // Содержимое корзины
        $this->design->assign('cart',		$this->cart->get_cart());
        
        // Избранное
        $wished = (array)explode(',', $_COOKIE['wished_products']);
        $this->design->assign('wished_products', ($wished[0] > 0) ? $wished : array());
        
        // Сравнение
        //unset($_SESSION['comparison']);
		$this->design->assign('comparison', $this->comparison->get_comparison());
        
        // Категории товаров
        $this->design->assign('categories', $this->categories->get_categories_tree());
        
        // Страницы
        $pages = $this->pages->get_pages(array('visible'=>1));
        $this->design->assign('pages', $pages);
        
        // Текущий модуль (для отображения центрального блока)
        $module = $this->request->get('module', 'string');
        $module = preg_replace("/[^A-Za-z0-9]+/", "", $module);
        
        // Если не задан - берем из настроек
        if(empty($module)) {
            return false;
        }
        //$module = $this->settings->main_module;
        
        // Создаем соответствующий класс
        if (is_file($this->modules_dir."$module.php")) {
            include_once($this->modules_dir."$module.php");
            if (class_exists($module)) {
                $this->main = new $module($this);
            } else {
                return false;
            }
        } else {
            return false;
        }
        
        // Создаем основной блок страницы
        if (!$content = $this->main->fetch()) {
            return false;
        }
        
        // Передаем основной блок в шаблон
        $this->design->assign('content', $content);
        
        // Передаем название модуля в шаблон, это может пригодиться
        $this->design->assign('module', $module);
        
        // Создаем текущую обертку сайта (обычно index.tpl)
        $wrapper = $this->design->get_var('wrapper');
        if(is_null($wrapper)) {
            $wrapper = 'index.tpl';
        }
        
        if(!empty($wrapper)) {
            return $this->body = $this->design->fetch($wrapper);
        } else {
            return $this->body = $content;
        }
    }
    
}