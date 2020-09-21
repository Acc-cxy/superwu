//重构失败代码
// import {
//   ADD_TO_CART,
//   ADD_COUNTER
// } from "@/store/mutations-type";

// export default {
//     addjoin(context,payload){
//         //查找之前是否有此商品
//         let oldproduct = context.state.cartlist.find(item => item.iid === payload.iid)
//         // 2.判断oldproduct
//         if (oldproduct) {
//             // let oldproduct = state.cartlist[index]
//             // oldproduct.count +=1
//             context.commit(ADD_COUNTER,oldproduct)
//             console.log('有了')
//         } else {
//             payload.count = 1
//             context.commit(ADD_TO_CART,oldproduct)
//             // context.state.cartlist.push(payload)
//             console.log('没有')
//         }
//
//     }
// }