export default {
    addjoinone(state,payload){
        // patload新添加的商品
        // let oldproduct = null;
        // for(let item of state.cartlist){
        //     if(item.iid === payload.iid){
        //         oldproduct = item;
        //     }
        // }
        //查找之前是否有此商品
        let oldproduct = state.cartlist.find(item => item.iid === payload.iid)
        // 2.判断oldproduct
        if (oldproduct) {
            // let oldproduct = state.cartlist[index]
            oldproduct.count +=1
            console.log('有了')
            console.log(oldproduct)
        } else {
            payload.count = 1
            payload.checked = true
            state.cartlist.push(payload)
        }

    }
}


//重构失败代码
// import {
//     ADD_COUNTER,
//     ADD_TO_CART
// } from "@/store/mutations-type";
//
// export default {
//     [ADD_COUNTER](state,payload){
//         payload.count++
//     },
//     [ADD_TO_CART](state,payload){
//         state.cartlist.push(payload)
//     }
// }

