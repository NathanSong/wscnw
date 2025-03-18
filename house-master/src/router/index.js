import Vue from 'vue'
import VueRouter from 'vue-router'
import login from '@/views/login.vue'
import regist from '@/views/regist.vue'

import adminHome from '@/views/adminHome.vue'
import userHome from '@/views/userHome.vue'
import userAdmin from '@/views/adminHome/userAdmin.vue'
import firstpage from '@/views/adminHome/firstpage.vue'
import adminMessageBoard from '@/views/adminHome/adminMessageBoard.vue'
import reportManagement from '@/views/adminHome/reportManagement.vue'
import appealManagement from '@/views/adminHome/appealManagement.vue'
import BuyManagement from '@/views/adminHome/BuyManagement.vue';
import contractManagement from '@/views/adminHome/contractManagement.vue'; // 新增



import firstHome from '@/views/userHome/firstHome.vue'
import userHouse from '@/views/userHome/userHouse.vue'
import userHouseDetail from '@/views/userHome/userHouseDetail.vue'
import userInfo from '@/views/userHome/userInfo.vue'
import userMessageBoard from '@/views/userHome/userMessageBoard.vue'
import userHouseShow from '@/views/userHome/userHouseShow.vue'
import userHouseBuy from '@/views/userHome/userHouseBuy.vue';
import userContract from '@/views/userHome/userContract.vue'; // 新增


import landlordHome from '@/views/landlordHome.vue'
import landlordMessageBoard from '@/views/landlordHome/landlordMessageBoard.vue'
import landlordHouseDetail from '@/views/landlordHome/landlordHouseDetail.vue'
import landlordHouseShow from '@/views/landlordHome/landlordHouseShow.vue'
import landlordInfo from '@/views/landlordHome/landlordInfo.vue'
import landlordHouse from '@/views/landlordHome/landlordHouse.vue'
import landlordAppeal from '@/views/landlordHome/landlordAppeal.vue'
import landlordHouseBuy from '@/views/landlordHome/landlordHouseBuy.vue';

Vue.use(VueRouter)

const routes = [
    { path: "/", redirect: "/login" },
    { path: "/login", component: login },
    { path: "/regist", component: regist },
    {
        path: "/adminHome",
        component: adminHome,
        children: [
            { path: "/", redirect: "firstpage" },
            { path: "firstpage", component: firstpage },
            { path: "adminMessageBoard", component: adminMessageBoard },
            { path: "userAdmin", component: userAdmin },
            { path: "reportManagement", component: reportManagement },
            { path: "appealManagement", component: appealManagement },
            { path: "BuyManagement", component: BuyManagement }, // 购买申请管理
            { path: 'contractManagement', component: contractManagement }, // 新增

        ]
    },
    {
        path: "/userHome",
        component: userHome,
        children: [
            { path: "/", redirect: "firstHome" },
            { path: "firstHome", component: firstHome },
            { path: "userInfo", component: userInfo },
            { path: "userMessageBoard", component: userMessageBoard },
            { path: "userHouse", component: userHouse },
            { path: "userhouse/detail/:houseid", component: userHouseDetail },
            { path: "houseShow", component: userHouseShow },
            { path: "userHouseBuy", component: userHouseBuy }, // 用户购买申请
            { path: 'userContract', component: userContract }, // 新增

        ]
    },
    {
        path: "/landlordHome",
        component: landlordHome,
        children: [
            { path: "/", redirect: "firstHome" },
            { path: "firstHome", component: firstHome },
            { path: "houseMessage", component: landlordMessageBoard },
            { path: "landlordHouse", component: landlordHouse },
            { path: "userhouse/detail/:houseid", component: landlordHouseDetail },
            { path: "landlordHouseShow", component: landlordHouseShow },
            { path: "landlordAppeal", component: landlordAppeal },
            { path: "landlordInfo", component: landlordInfo },
            { path: "landlordHouseBuy", component: landlordHouseBuy }, // 房东购买申请
        ]
    }
]

const router = new VueRouter({
    routes
})

// 前置守卫
router.beforeEach(function(to, from, next) {
    const arr = ['/adminHome', '/userHome', '/landlordHome']
    if (arr.indexOf(to.path) != -1) {
        const token = localStorage.getItem('token')
        if (token) {
            const user = JSON.parse(token)
            if (to.path.startsWith('/landlordHome') && user.admin === 3) {
                next()
            } else if (to.path.startsWith('/userHome') && user.admin !== 3) {
                next()
            } else {
                next('/login')
            }
        } else {
            next('/login')
        }
    } else {
        next()
    }
})

export default router