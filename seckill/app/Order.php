<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    /**
     * 与模型关联的表名
     *
     * @var string
     */
    protected $table = 'pre_order';
    /**
     * 可以被批量赋值的属性。
     *
     * @var array
     */
    protected $fillable = ['number','user_id','product_id', 'quantity','product_fee', 'status','delivery_status','payment_status'];
}

