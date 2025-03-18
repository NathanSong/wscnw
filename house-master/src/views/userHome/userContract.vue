<template>
  <div>
      <h2>我的合同</h2>
      <el-table :data="contracts" style="width: 100%;" border v-loading="loading">
          <el-table-column prop="contractid" label="合同ID" width="100"></el-table-column>
          <el-table-column prop="houseid" label="房屋ID" width="100"></el-table-column>
          <el-table-column prop="buyer" label="买家"></el-table-column>
          <el-table-column prop="seller" label="卖家"></el-table-column>
          <el-table-column prop="contractDate" label="合同日期" width="180">
              <template slot-scope="scope">
                  {{ formatDate(scope.row.contractDate) }}
              </template>
          </el-table-column>
          <el-table-column prop="order" label="申请内容"></el-table-column>
          <el-table-column prop="status" label="状态" width="120">
              <template slot-scope="scope">
                  {{ translateStatus(scope.row.status) }}
              </template>
          </el-table-column>
          <el-table-column prop="adminstatus" label="管理员状态" width="120">
              <template slot-scope="scope">
                  {{ translateStatus(scope.row.adminstatus) }}
              </template>
          </el-table-column>
      </el-table>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  data() {
      return {
          contracts: [],
          loading: false,
      };
  },
  created() {
      this.fetchContracts();
  },
  methods: {
      async fetchContracts() {
          this.loading = true;
          try {
              const user = JSON.parse(localStorage.getItem("token"));
              if (!user || !user.username) {
                  console.error("用户信息缺失或无效");
                  this.$message.error("用户信息缺失，请重新登录");
                  return;
              }
              const response = await request({
                  method: "get",
                  url: "/contract/user/" + user.username,
              });
              this.contracts = response.data.data || [];
          } catch (error) {
              console.error("获取合同列表失败:", error);
              this.$message.error("获取合同列表失败，请稍后重试");
              this.contracts = [];
          } finally {
              this.loading = false;
          }
      },

      formatDate(dateString) {
          if (!dateString) return "";
          const date = new Date(dateString);
          const beijingTime = new Date(date.getTime() + 8 * 60 * 60 * 1000);
          return beijingTime.toISOString().replace("T", " ").substring(0, 19);
      },

      translateStatus(status) {
          switch (status) {
              case "pending":
                  return "待处理";
              case "approved":
                  return "已通过";
              case "rejected":
                  return "已拒绝";
              default:
                  return status;
          }
      },
  },
};
</script>

<style scoped>
.container {
  padding: 20px;
}
</style>