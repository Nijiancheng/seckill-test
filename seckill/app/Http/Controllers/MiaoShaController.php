<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use mysql_xdevapi\Exception;
//use \Redis;
use Illuminate\Support\Facades\Redis;
use App\Product;
use App\Order;
use Illuminate\Support\Str;

class MiaoShaController extends Controller
{
//    public $redis;

//    /**
//     * 链接redis
//     * MiaoShaController constructor.
//     */
//    public function __construct(){
//        Redis:: new Redis();
//        $result = Redis::connect('redis','6379');
//        if($result){
//            dump('redis链接成功');
//        }
//    }

    /**
     * 设置秒杀商品
     * @param Request $request
     * @return array
     */
    public function set_seckill(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, $this->checkSeckillPro(), $this->getMsg());
        if ($validator->fails()) {
            return ['status' => false, 'msg' => data_get($validator->errors()->messages(), '*.0')[0]];
        }
        $product = Product::find($input['product_id']);
        if (empty($product)){
            return ['status'=>false,'msg'=>'商品不存在'];
        }
        for ($i = 0 ;$i<$product->quantity;$i++){
            Redis::rPush('product'.$product->id,$product->id);
        }
        return ['status'=>true,'msg'=>'商品加入秒杀列表成功'];
    }

    /**
     * 秒杀商品处理
     * @param Request $request
     */
    public function seckill(Request $request){
        $input = $request->all();
        $validator= Validator::make($input,$this->checkSeckill(),$this->getMsg());
        if($validator->fails()){
            return ['status'=>false,'msg'=>data_get($validator->errors()->messages(),'*.0')[0]];
        }
        $quota = Redis::lrange('quota:'.$input['product_id'],0,-1);
        if(in_array($input['user_id'],$quota)){
            return ['status'=>false,'msg'=>'此商品每人限购一件'];
        };
        $res = Redis::lpop('product'.$input['product_id']);
        if ($res == 0){
            return ['status'=>false,'msg'=>'秒杀失败'];
        }
        Redis::rpush('orderInfo',$input['user_id'].','.$input['product_id']);
        Redis::rpush('quota:'.$input['product_id'],$input['user_id']);
        return ['status'=>true,'msg'=>'秒杀成功'];
    }


    /**
     * 验证设置秒杀商品信息
     * @return array
     */
    public function checkSeckillPro(){
        return[
            'product_id'=>[
                'required',
                'integer',
            ]
        ];
    }

    /**
     * 验证秒杀信息
     * @return array
     */
    public function checkSeckill(){
        return[
            'product_id'=>[
                'required',
                'integer',
            ],
            'user_id'=>[
                'required',
                'integer',
            ],
            'quantity'=>[
                'required',
                'integer',
                'min:1',
                'max:1'
            ]
        ];
    }

    /**
     * @return array
     */
    public function getMsg(){
        return [
            'product_id.required'=>'商品id不可为空',
            'product_id.integer'=>'商品id不合法',
            'user_id.required'=>'用户id不可为空',
            'user_id.integer'=>'用户id不合法',
            'quantity.required'=>'购买数量不能为空',
            'quantity.integer'=>'购买数量不合法',
            'quantity.min'=>'购买数量最少1件',
            'quantity.max'=>'每人限购1件'
        ];
    }
}
