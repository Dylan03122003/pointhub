package util;

import java.util.ArrayList;

public class CustomLog {
	public static <T> void logList(ArrayList<T> list) {
		for (T item : list) {
			System.out.println(item);
		}
	}

}
