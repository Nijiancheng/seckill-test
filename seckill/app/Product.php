<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    const STATUS_SECKILL = 10;
    const QUANTITY_LIMIT = 1;
    /**
     * 与模型关联的表名
     *
     * @var string
     */
    protected $table = 'pre_product';
    /**
     * 可以被批量赋值的属性。
     *
     * @var array
     */
    protected $fillable = ['name', 'quantity', 'price', 'status'];


}

