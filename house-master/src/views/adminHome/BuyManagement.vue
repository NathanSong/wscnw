<template>
  <div>
    <h2>购买申请管理</h2>
    <!-- 购买申请列表 -->
    <el-table :data="buyRequests" style="width: 100%">
      <el-table-column prop="requestid" label="申请ID"></el-table-column>
      <el-table-column prop="houseid" label="房屋ID"></el-table-column>
      <el-table-column prop="buyer" label="购买者"></el-table-column>
      <el-table-column prop="landlordname" label="卖家"></el-table-column>
      <el-table-column prop="buyContent" label="申请内容"></el-table-column>
      <el-table-column prop="requestDate" label="用户申请时间">
        <template slot-scope="scope">
          {{ formatDate(scope.row.requestDate) }} <!-- 格式化日期 -->
        </template>
      </el-table-column>
      <el-table-column label="状态">
        <template slot-scope="scope">
          <el-tag :type="getStatusTagType(scope.row.status)">
            {{ translateStatus(scope.row.status) }} <!-- 状态转换为中文 -->
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            type="primary"
            @click="handleApprove(scope.row.requestid)"
            :disabled="scope.row.status !== 'pending'"
          >
            同意
          </el-button>
          <el-button
            type="danger"
            @click="handleReject(scope.row.requestid)"
            :disabled="scope.row.status !== 'pending'"
          >
            拒绝
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页栏 -->
    <div class="block">
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="currentPage"
        :page-sizes="[5, 10, 15, 20]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
      >
      </el-pagination>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  data() {
    return {
      buyRequests: [], // 当前页的数据
      currentPage: 1, // 当前页码
      pageSize: 10, // 每页大小
      total: 0, // 总记录数
    };
  },
  created() {
    this.fetchBuyRequests();
  },
  methods: {
    // 获取分页数据
    async fetchBuyRequests() {
      try {
        const response = await request({
          method: "get",
          url: "/buy/requests/admin/paged",
          params: {
            page: this.currentPage,
            pageSize: this.pageSize,
          },
        });
        const data = response.data.data;
        this.buyRequests = data.rows; // 当前页的数据
        this.total = data.total; // 总记录数
      } catch (error) {
        console.error("获取购买申请失败", error);
        this.$message.error("获取购买申请失败，请稍后重试");
      }
    },
    // 改变每页显示条数
    handleSizeChange(val) {
      this.pageSize = val;
      this.fetchBuyRequests();
    },
    // 改变当前页
    handleCurrentChange(val) {
      this.currentPage = val;
      this.fetchBuyRequests();
    },
    // 同意申请
    async handleApprove(requestid) {
      try {
        await request({
          method: "put",
          url: `/buy/request/${requestid}/status`,
          params: { status: "approved" },
        });
        this.fetchBuyRequests();
        this.$message.success("申请已通过");
      } catch (error) {
        console.error("同意申请失败", error);
        this.$message.error("同意申请失败，请稍后重试");
      }
    },
    // 拒绝申请
    async handleReject(requestid) {
      try {
        await request({
          method: "put",
          url: `/buy/request/${requestid}/status`,
          params: { status: "rejected" },
        });
        this.fetchBuyRequests();
        this.$message.success("申请已拒绝");
      } catch (error) {
        console.error("拒绝申请失败", error);
        this.$message.error("拒绝申请失败，请稍后重试");
      }
    },
    // 根据状态返回标签类型
    getStatusTagType(status) {
      switch (status) {
        case "pending":
          return "info";
        case "approved":
          return "success";
        case "rejected":
          return "danger";
        default:
          return "danger";
      }
    },
    // 将状态转换为中文
    translateStatus(status) {
      switch (status) {
        case "pending":
          return "待处理";
        case "approved":
          return "已通过";
        case "rejected":
          return "未通过";
        default:
          return status;
      }
    },
    // 格式化日期
    formatDate(dateString) {
      if (!dateString) return ""; // 如果日期为空，返回空字符串
      const date = new Date(dateString);
      // 转换为北京时间（UTC+8）
      const beijingTime = new Date(date.getTime() + 8 * 60 * 60 * 1000);
      // 格式化为 YYYY-MM-DD HH:mm:ss
      return beijingTime.toISOString().replace("T", " ").substring(0, 19);
    },
  },
};
</script>

<style scoped>
h2 {
  margin-bottom: 20px;
}
</style>
