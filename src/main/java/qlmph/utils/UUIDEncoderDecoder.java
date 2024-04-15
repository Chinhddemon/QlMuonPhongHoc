package qlmph.utils;

public class UUIDEncoderDecoder {

	public static String convertUuidString(String uuidString) {
		String[] parts = uuidString.split("-");
		StringBuilder sb = new StringBuilder();

		for (int i = 0; i < parts.length; i++) {
			if (i != 0) {
				sb.append("-");
			}
			if (i <= 2) {
				char[] uuidChars = parts[i].toCharArray();
				reverseArray(uuidChars);
				swapPairs(uuidChars);
				sb.append(new String(uuidChars));
			} else {
				sb.append(parts[i]);
			}
		}

		return sb.toString();
	}

	private static void reverseArray(char[] arr) {
		int start = 0;
		int end = arr.length - 1;
		while (start < end) {
			char temp = arr[start];
			arr[start] = arr[end];
			arr[end] = temp;
			start++;
			end--;
		}
	}

	private static void swapPairs(char[] arr) {
		for (int i = 0; i < arr.length - 1; i += 2) {
			char temp = arr[i];
			arr[i] = arr[i + 1];
			arr[i + 1] = temp;
		}
	}
	
	public static void main(String[] args) {
		System.out.println(convertUuidString("58edb354-1115-4550-a437-b3425aabc60a"));
	}
}
