import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
	state:{
		cartlist:[]
	},
	mutations:{
		addCounter(state,payload){
			payload.count++
		},
		addToCart(state,payload){
			state.cartlist.push(payload)
		}
	},
	actions:{
		addjoin(context,payload){
			//查找之前是否有此商品
			let oldproduct = context.state.cartlist.find(item => item.iid === payload.iid)
			// 2.判断oldproduct
			if (oldproduct) {
				// let oldproduct = state.cartlist[index]
				// oldproduct.count +=1
				context.commit('addCounter',oldproduct)
				console.log('有了')
			} else {
				payload.count = 1
				context.commit('addToCart',oldproduct)
				// context.state.cartlist.push(payload)
				console.log('没有')
			}

		}
	}
})

export default store