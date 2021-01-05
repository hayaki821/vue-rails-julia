<template>
  <form>
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li>
          <p color="red">{{ e }}</p>
        </li>
      </ul>
    </div>
    <div>
      <label>Name</label>
      <input v-model="employee.name" type="text" />
    </div>
    <div>
      <label>Department</label>
      <input v-model="employee.department" type="text" />
    </div>
    <div>
      <label>Gender</label>
      <select v-model="employee.gender">
        <option>other</option>
        <option>male</option>
        <option>female</option>
      </select>
    </div>
    <div>
      <label>Birth</label>
      <input v-model="employee.birth" type="date" />
    </div>
    <div>
      <label>Joined Date</label>
      <input v-model="employee.joined_date" type="date" />
    </div>
    <div>
      <label>Payment</label>
      <input v-model="employee.payment" type="number" min="0" />
    </div>
    <div>
      <label>Note</label>
      <input v-model="employee.note" type="text" />
    </div>
    <button @click.prevent="$emit('submit')">Commit</button>
  </form>
  <div class="row">
    <div class="col s10 m11">
      <input
        v-model="newTask"
        class="form-control"
        placeholder="Add your task!!"
      />
    </div>
    <div class="col s2 m1">
      <div
        @click="createTask"
        class="btn-floating waves-effect waves-light red"
      >
        <i class="material-icons">add</i>
      </div>
    </div>
  </div>
</template>
<script>
import { ref, reactive } from "vue";
export default {
  name: "juliaCreate",
  setup() {
    const juliaParams = reactive({
      min_x: "",
      max_x: "",
      min_y: "",
      max_y: "",
      comp_const: "",
    });
    const compConstRe = ref("");
    const compConstIm = ref("");
    const errors = ref([]);
  },
};
</script>