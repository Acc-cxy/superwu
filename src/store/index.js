import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
    state:{
        cartlist:[]
    },
    mutations:{
        addjoin(state,payload){
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
            } else {
                payload.count = 1
                state.cartlist.push(payload)
                console.log('没有')
            }

        }
    }
})

export default store