<template>
  <div class="container">
    <h2>我的购买申请</h2>
    <table class="table">
      <thead>
        <tr>
          <th>房屋ID</th>
          <th>申请内容</th>
          <th>申请时间</th>
          <th>状态</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="request in buyRequests" :key="request.requestid">
          <td>{{ request.houseid }}</td>
          <td>{{ request.buyContent }}</td>
          <td>{{ request.requestDate }}</td>
          <td>{{ request.status }}</td>
        </tr>
      </tbody>
    </table>
    <!-- 分页组件 -->
    <div class="pagination">
      <el-pagination
        background
        layout="prev, pager, next"
        :total="total"
        :page-size="pageSize"
        :current-page="currentPage"
        @current-change="handlePageChange"
      />
    </div>
  </div>
</template>

<script>
import request from "@/utils/request"; // 引入 request 工具类

export default {
  data() {
    return {
      buyRequests: [], // 购买申请列表
      total: 0, // 总记录数
      pageSize: 10, // 每页显示条数
      currentPage: 1, // 当前页码
    };
  },
  created() {
    this.fetchBuyRequests();
  },
  methods: {
    async fetchBuyRequests() {
      try {
        const user = JSON.parse(localStorage.getItem("token"));
        if (!user || !user.username) {
          console.error("User information is missing or invalid");
          return;
        }
        const response = await request({
          method: "get",
          url: "/buy/requests/paged", // 调用分页查询接口
          params: {
            buyer: user.username,
            page: this.currentPage,
            pageSize: this.pageSize,
          },
        });
        this.buyRequests = response.data.data.rows; // 获取当前页数据
        this.total = response.data.data.total; // 获取总记录数
      } catch (error) {
        console.error("Failed to fetch buy requests:", error);
      }
    },
    // 分页切换事件
    handlePageChange(page) {
      this.currentPage = page;
      this.fetchBuyRequests();
    },
  },
};
</script>

<style scoped>
.container {
  padding: 20px;
}
.table {
  width: 100%;
  border-collapse: collapse;
}
.table th,
.table td {
  border: 1px solid #ddd;
  padding: 8px;
}
.table th {
  background-color: #f2f2f2;
}
.pagination {
  margin-top: 20px;
  text-align: center;
}
</style>
