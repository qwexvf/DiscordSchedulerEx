<template>
  <div class="container">
    <h1>スケジュールを作成</h1>
      <b-card
    tag="article"
    class="mb-2">
    <b-form @submit="onSubmit">
      <b-form-group id="input-group-1" label="内容" label-for="input-1">
        <b-form-textarea id="textarea" v-model="message" rows="3" max-rows="6"></b-form-textarea>
      </b-form-group>

      <ImagePreview :image.sync="file" @update:image="val => mag = val" />

      <TimePicker
        :time.sync="time"
        @update:time="val => mag = val"
        :reservation_date.sync="reservation_date"
        @update:reservation_date="val => mag = val"
      />

      <b-button type="submit" variant="primary">保存</b-button>
      <b-button type="reset" variant="danger" @click="onReset">キャンセル</b-button>
    </b-form>
  </b-card>

  </div>
</template>

<script lang="ts">
import axios from "axios";
import ImagePreview from "~/components/ImagePreview.vue";
import TimePicker from "~/components/TimePicker.vue";
import { Component, Vue } from "nuxt-property-decorator";

@Component({
  components: {
    ImagePreview,
    TimePicker
  }
})
export default class extends Vue {
  private message: string = "@everyone\n";
  private reservation_date: Date = new Date();

  private time: string = "00:00";
  private file: string | null = null;

  async onSubmit(e: Event) {
    e.preventDefault();

    let reservation_date = new Date(`${this.reservation_date} ${this.time}`);

    let form = new FormData();

    let data = {
          message: this.message,
          reservation_date: reservation_date,
    };
    
    form.append("schedule", JSON.stringify(data));

    let headers = {};

    if (this.file) {
      form.append("image", this.file);
      headers = { "Content-Type": "multipart/form-data" };
    }

    try {
      const response = await axios.post(
        `${process.env.VUE_APP_API}/schedules`,
        form,
        headers
      );
      if (response.data) {
        this.$router.push("/");
      }
    } catch {
      console.log("error");
    }
  }

  onReset(e: Event) {
    e.preventDefault();
    this.$router.push("/");
  }
}
</script>
