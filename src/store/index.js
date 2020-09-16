import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
    state:{
        cartlist:[]
    },
    mutations:{
        addjoin(state,payload){
            state.cartlist.push(payload)
        }
    }
})

export default store